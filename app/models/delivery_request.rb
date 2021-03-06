class DeliveryRequest < ApplicationRecord

  belongs_to :community_member, optional: true
  belongs_to :delivery_route, optional: true
  has_many :comments

  include ActiveModel::Validations
  validates_with DateValidator
  validates :items, :requested_date, presence: true

  scope :pending, -> { where(status: "new") }
  scope :confirmed, -> { where(status: "confirmed") }
  scope :completed, -> { where(status: "completed") }

  scope :today, -> { where(requested_date: Time.now.strftime('%m/%d/%Y') )}

  # Get the current member from the session hash
  # and add this delivery request to that member's
  # delivery requests
  def associate_member(session)
    if (session[:user_type] == 'community-members')
      member = CommunityMember.find(session[:user_id])
      member.delivery_requests << self
      member.save
    end
  end

  def volunteer_name
    self.delivery_route.volunteer.name
  end

  def volunteer
    self.delivery_route.volunteer
  end

  def delivery_route_size
    self.delivery_route.delivery_requests.size
  end

  # Used to ensure that this instance of DeliveryRequest belongs to the current member
  def matches_current_member(user_type, current_member_id)
    (user_type == 'community-members') && (self.community_member.id == current_member_id)
  end

  # To be able to be edited, this delivery request must belong to the current member
  # and be in "new" status
  def is_valid_for_edit(user_type, current_member_id)
    self.matches_current_member(user_type, current_member_id) && (self.status == "new")
  end

  # To be able to be edited (from volunteer perspective), the volunteer of this delivery
  # request needs to be the volunteer that is currently logged in. However, if there is no
  # volunteer assigned yet (i.e. the delivery route is empty), then the delivery request is
  # able to be edited from volunteer perspective
  def is_valid_for_volunteer(session)
    session[:user_type] == 'volunteers' && (!self.delivery_route || self.volunteer.id == session[:user_id])
  end

  # This method contains the logic involved for updating the status of a delivery request
  def update_status(prev_status, vol_id)
    if prev_status == "new"
      if self.status != "confirmed"
        # That's an error, because a delivery request can't jump from "new" status
        # directly to "completed". Thus, display error message and redirect to the delivery request
        session[:message] = "A delivery can not be marked as completed unless it is first confirmed by a volunteer"
        redirect_to delivery_request_path(self)
      else
        # Either find a route that has the date, or create a new one
        Volunteer.find(vol_id).find_or_create_new_route(self)
      end
    elsif prev_status == "confirmed"
      if self.status == "new"
        # If this delivery request was the only item it the route it belonged to,
        # then destroy the entire route
        self.delivery_route.destroy if (self.delivery_route_size == 1)

        # Otherwise, remove the association with the delivery route
        self.delivery_route_id = nil
        self.save
      end
    elsif prev_status == "completed"
      if self.status == "new"
        # If this delivery request was the only item it the route it belonged to,
        # then destroy the entire route
        self.delivery_route.destroy if (self.delivery_route_size == 1)

        # Otherwise, remove the association with the delivery route
        self.delivery_route_id = nil
        self.save
      elsif self.status == "confirmed"
        # Either find a route that has the date, or create a new one
        Volunteer.find(vol_id).find_or_create_new_route(self)
      end
    else
      # Error state. This should never be reached, and if it is it means that
      # at some point the delivery request's status was updated to something other
      # than new/confirmed/completed (which, for the first version of this app, are
      # the only possible states for delivery requests)
      session[:message] = "Previous status is out-of-bounds"
      redirect_to '/delivery-requests'
    end
  end

  # To be able to be deleted, a delivery request's status must either be
  # "new", or "confirmed" and the date is not today.
  # This is to prevent changes being made to an order the day-of as volunteers
  # are potentially already on the way or have already purchased the food.
  def is_valid_for_deletion
    (self.status == "new") || self.is_valid_for_deletion_confirmed
  end

  def is_valid_for_deletion_confirmed
    (self.status == "confirmed") && self.date_is_not_today
  end

  def date_is_not_today
    self.requested_date != Time.now.strftime('%m/%d/%Y')
  end

  def date_is_today
    !self.date_is_not_today
  end

end
