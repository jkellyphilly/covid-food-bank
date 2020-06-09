class DeliveryRoute < ApplicationRecord

  belongs_to :volunteer
  has_many :delivery_requests
  has_many :community_members, through: :delivery_requests

  # TODO: add a validation to check and ensure that there's only one route per date per volunteer

end
