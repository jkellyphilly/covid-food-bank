class Comment < ApplicationRecord

  belongs_to :delivery_request
  belongs_to :community_member, optional: true
  belongs_to :volunteer, optional: true

  # The UserValidator here is used to ensure that the comment never
  # belongs to both a community member AND a volunter; at most it
  # can belong to 1 of the two.
  include ActiveModel::Validations
  validates_with UserValidator
  validates :content, presence: true

  # Print the time in a more user-friendly format
  def print_time
    self.updated_at.strftime('%B %e, %Y at %l:%M %P')
  end
end
