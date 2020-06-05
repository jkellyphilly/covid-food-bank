class CommunityMember < ApplicationRecord
  has_secure_password

  has_many :delivery_requests
  has_many :volunteers, through: :delivery_requests
  has_many :comments

  validates :name, :address, :email, :phone_number, presence: true
end
