class Volunteer < ApplicationRecord
  has_secure_password

  has_many :delivery_routes
  has_many :community_members, through: :delivery_routes
  has_many :comments

  def isLoggedIn
    true
  end
end
