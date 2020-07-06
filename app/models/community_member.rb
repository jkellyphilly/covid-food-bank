class CommunityMember < ApplicationRecord
  has_secure_password

  has_many :delivery_requests
  has_many :volunteers, through: :delivery_requests
  has_many :comments

  validates :name, :email, :username, presence: true
  validates :username, uniqueness: true

  def is_logged_in(session)
    session[:user_id] == self.id && session[:user_type] == 'community-members' ? true : false
  end

  def pending_delivery_requests
    self.delivery_requests.pending
  end

  def confirmed_delivery_requests
    self.delivery_requests.confirmed
  end

  def completed_delivery_requests
    self.delivery_requests.completed
  end

  def todays_confirmed_requests
    self.delivery_requests.today.confirmed
  end

  def todays_completed_requests
    self.delivery_requests.today.completed
  end
end
