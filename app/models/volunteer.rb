class Volunteer < ApplicationRecord
  has_secure_password

  has_many :delivery_routes
  has_many :community_members, through: :delivery_routes
  has_many :comments

  validates :name, :email, :username, presence: true
  validates :username, uniqueness: true

  # Check the session hash to see if the :user_id key matches this instance
  # of Volunteer and check if the :user_type key is set to volunteers
  def is_logged_in(session)
    ((session[:user_id] == self.id) && (session[:user_type] == 'volunteers')) ? true : false
  end

  # Delivery routes are grouped by date, so this method first looks for a non-completed route
  # that belong to the current Volunteer which has the same date as the delivery request in
  # question. If one is not found, then a new route is created
  def find_or_create_new_route(delivery_request)
    existing = self.delivery_routes.find {|rt| (rt.estimated_delivery_date == delivery_request.requested_date) && (rt.status != "completed")}
    if existing
      existing.delivery_requests << delivery_request
      existing
    else
      new_route = DeliveryRoute.create(estimated_delivery_date: delivery_request.requested_date, volunteer_id: self.id)
      new_route.delivery_requests << delivery_request
      new_route
    end
  end

  def upcoming_delivery_routes
    self.delivery_routes.upcoming
  end

  def completed_delivery_routes
    self.delivery_routes.completed
  end
end
