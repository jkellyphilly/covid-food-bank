class CommunityMember < ApplicationRecord
  has_secure_password

  has_many :delivery_requests
  has_many :volunteers, through: :delivery_requests
  has_many :comments

  validates :name, :address, :email, :phone_number, :username, presence: true
  validates :username, uniqueness: true
  # TODO: set up a validation for the phone number
  # TODO: figure out why the password is showing on Google that it's compromised

  def isLoggedIn(session)
    session[:user_id] == self.id && session[:user_type] == 'community-members' ? true : false
  end

  def pending_delivery_requests
    self.delivery_requests.select {|dr| dr.status == "new"}
  end

  def confirmed_delivery_requests
    self.delivery_requests.select {|dr| dr.status == "confirmed"}
  end

  def completed_delivery_requests
    self.delivery_requests.select {|dr| dr.status == "completed"}
  end
end
