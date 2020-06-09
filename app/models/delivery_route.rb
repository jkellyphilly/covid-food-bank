class DeliveryRoute < ApplicationRecord

  belongs_to :volunteer
  has_many :delivery_requests
  has_many :community_members, through: :delivery_requests

  def belongsToCurrentVolunteer(session)
    (self.volunteer_id == session[:user_id]) && (session[:user_type] == 'volunteers')
  end

end
