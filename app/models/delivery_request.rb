class DeliveryRequest < ApplicationRecord

  belongs_to :community_member
  belongs_to :delivery_route
  has_many :comments
end
