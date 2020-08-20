class DeliveryRoute < ApplicationRecord

  belongs_to :volunteer
  has_many :delivery_requests
  has_many :community_members, through: :delivery_requests

  scope :upcoming, -> { where(status: "confirmed") }
  scope :completed, -> { where(status: "completed") }

  # Check to see if this route's volunteer is the current user of the application
  def belongs_to_current_volunteer(session)
    (self.volunteer_id == session[:user_id]) && (session[:user_type] == 'volunteers')
  end

  def update_all_statuses(new_status)
    self.delivery_requests.each do |dreq|
      dreq.status = new_status
      if new_status == "new"
        dreq.delivery_route_id = nil
      end

      dreq.save
    end
  end

  # Any route that hasn't been completed is valid for deletion
  def is_valid_for_deletion
    self.status != "completed"
  end

  # Generates a list of all the items from all of the delivery requests
  # that belong to this route
  def all_items
    unique_request_items = self.delivery_requests.uniq {|dreq| dreq.items}
    unique_request_items.collect {|dreq| dreq.items}
  end

end
