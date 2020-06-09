class DeliveryRequest < ApplicationRecord

  belongs_to :community_member
  belongs_to :delivery_route, optional: true
  has_many :comments

  validates :items, :requested_date, presence: true
  # TODO: create custom validation for date input

  scope :pending, -> { where(status: "new") }
  scope :confirmed, -> { where(status: "confirmed") }
  # TODO: create a "confirmed" scope action
  # TODO: split confirmed into both "vol_confirmed" and "confirmed"
  # TODO: create a custom validation for saving the different statuses?

  # TODO: add in a "change delivery status" option on the VIEW side (show)

  def associateMember(session)
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

  def matchesCurrentMember(user_type, current_member_id)
    (user_type == 'community-members') && (self.community_member.id == current_member_id)
  end

  def statusIsValidForEdit
    (self.status == "new") || (self.status == "confirmed")
  end

  def isValidForEdit(user_type, current_member_id)
    self.matchesCurrentMember(user_type, current_member_id) && self.statusIsValidForEdit
  end

  def matchesCurrentVolunteer
    session[:user_type] == 'volunteers' && self.volunteer.id == session[:user_id]
    binding.pry
  end

  def update_status(prev_status, vol_id)
    if prev_status == "new"
      if self.status != "confirmed"
        # TODO: error. There can't be a jump from new status to completed.
      else
        # TODO: combine this whole statement into one line
        volunteer = Volunteer.find(vol_id)

        # Either find a route that has the date, or create a new one
        volunteer.find_or_create_new_route(self)
      end
    elsif prev_status == "confirmed"
      if self.status == "new"
        self.delivery_route_id = nil
        self.save
      end
    end
  end

end
