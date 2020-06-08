class Volunteer < ApplicationRecord
  has_secure_password

  has_many :delivery_routes
  has_many :community_members, through: :delivery_routes
  has_many :comments

  validates :name, :email, :phone_number, :username, presence: true
  validates :username, uniqueness: true
  # TODO: set up a validation for the phone number

  # TODO: update this to be specific for the instance of the volunteer
  def isLoggedIn(session)
    session[:username] == self.username && session[:user_type] == 'volunteers' ? true : false
  end
end
