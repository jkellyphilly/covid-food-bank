class DeliveryRequest < ApplicationRecord

  belongs_to :community_member
  belongs_to :delivery_route, optional: true
  has_many :comments

  validates :items, :requested_date, presence: true

  def associateMember(session)
    if (session[:user_type] == 'community-members')
      member = CommunityMember.find(session[:user_id])
      member.delivery_requests << self
      member.save 
    end
  end
end
