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

  def delivery_route_size
    self.delivery_route.delivery_requests.size
  end

  def matchesCurrentMember(user_type, current_member_id)
    (user_type == 'community-members') && (self.community_member.id == current_member_id)
  end

  def statusIsValidForEdit
    self.status == "new"
  end

  def isValidForEdit(user_type, current_member_id)
    self.matchesCurrentMember(user_type, current_member_id) && self.statusIsValidForEdit
  end

  def matchesCurrentVolunteer
    session[:user_type] == 'volunteers' && self.volunteer.id == session[:user_id]
  end

  def update_status(prev_status, vol_id)
    if prev_status == "new"
      if self.status != "confirmed"
        # TODO: error. There can't be a jump from new status to completed.
      else
        # Either find a route that has the date, or create a new one
        Volunteer.find(vol_id).find_or_create_new_route(self)
      end
    elsif prev_status == "confirmed"
      if self.status == "new"
        self.delivery_route.destroy if (self.delivery_route_size == 1)

        self.delivery_route_id = nil
        self.save
      end
    end
  end

end
