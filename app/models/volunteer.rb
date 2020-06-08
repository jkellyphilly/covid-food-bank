class Volunteer < ApplicationRecord
  has_secure_password

  has_many :delivery_routes
  has_many :community_members, through: :delivery_routes
  has_many :comments

  validates :name, :email, :phone_number, :username, presence: true
  validates :username, uniqueness: true
  # TODO: set up a validation for the phone number

  def isLoggedIn(session)
    session[:user_id] == self.id && session[:user_type] == 'volunteers' ? true : false
  end
end
