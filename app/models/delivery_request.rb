class DeliveryRequest < ApplicationRecord

  belongs_to :community_member, optional: true
  belongs_to :delivery_route, optional: true
  has_many :comments

  include ActiveModel::Validations
  validates_with DateValidator
  validates :items, :requested_date, presence: true

  scope :pending, -> { where(status: "new") }
  scope :confirmed, -> { where(status: "confirmed") }
  scope :completed, -> { where(status: "completed") }

  def associate_member(session)
    if (session[:user_type] == 'community-members')
      member = CommunityMember.find(session[:user_id])
      member.delivery_requests << self
      member.save
    end
  end

  def volunteer_name
    self.delivery_route.volunteer.name
  end

  def volunteer
    self.delivery_route.volunteer
  end

  def delivery_route_size
    self.delivery_route.delivery_requests.size
  end

  def matches_current_member(user_type, current_member_id)
    (user_type == 'community-members') && (self.community_member.id == current_member_id)
  end

  def is_valid_for_edit(user_type, current_member_id)
    self.matches_current_member(user_type, current_member_id) && (self.status == "new")
  end

  def is_valid_for_volunteer(session)
    self.is_empty_delivery_route(session) || self.matches_current_volunteer(session)
  end

  def matches_current_volunteer(session)
    session[:user_type] == 'volunteers' && (self.volunteer.id == session[:user_id])
  end

  def is_empty_delivery_route(session)
    !self.delivery_route && (session[:user_type] == 'volunteers')
  end

  # TODO: define full status update logic
  def update_status(prev_status, vol_id)
    if prev_status == "new"
      if self.status != "confirmed"
        # TODO: error. There can't be a jump from new status to completed.
      else
        # Either find a route that has the date, or create a new one
        Volunteer.find(vol_id).find_or_create_new_route(self)
      end
    elsif prev_status == "confirmed"
      if self.status == "new"
        self.delivery_route.destroy if (self.delivery_route_size == 1)

        self.delivery_route_id = nil
        self.save
      end
    elsif prev_status == "completed"
      if self.status == "new"
        self.delivery_route.destroy if (self.delivery_route_size == 1)

        self.delivery_route_id = nil
        self.save
      elsif self.status == "confirmed"
        binding.pry
      end
    else
      # TODO: clean up the wording of this error
      session[:message] = "BAD ERROR."
      redirect_to '/delivery-requests'
    end
  end

end
