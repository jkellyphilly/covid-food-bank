class DeliveryRequest < ApplicationRecord

  belongs_to :community_member
  belongs_to :delivery_route, optional: true
  has_many :comments

  validates :items, :requested_date, presence: true
  # TODO: create custom validation for date input

  scope :pending, -> { where(status: "new") }
  scope :confirmed, -> { where(status: "confirmed") }
  # TODO: create a "confirmed" scope action

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
end
