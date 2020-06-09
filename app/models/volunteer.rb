class Volunteer < ApplicationRecord
  has_secure_password

  has_many :delivery_routes
  has_many :community_members, through: :delivery_routes
  has_many :comments

  validates :name, :email, :phone_number, :username, presence: true
  validates :username, uniqueness: true
  # TODO: set up a validation for the phone number

  def isLoggedIn(session)
    session[:user_id] == self.id && session[:user_type] == 'volunteers' ? true : false
  end

  def find_or_create_new_route(delivery_request)
    existing = self.delivery_routes.find {|rt| rt.estimated_delivery_date == delivery_request.requested_date}
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
    self.delivery_routes.select {|dr| dr.status == "confirmed"}
  end

  def completed_delivery_routes
    self.delivery_routes.select {|dr| dr.status == "completed"}
  end
end
