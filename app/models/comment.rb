class Comment < ApplicationRecord

  belongs_to :delivery_request
  belongs_to :community_member, optional: true
  belongs_to :volunteer, optional: true

  include ActiveModel::Validations
  validates_with UserValidator
  validates :content, presence: true

  def print_time
    self.updated_at.strftime('%B %e, %Y at %l:%M %P')
  end
end
