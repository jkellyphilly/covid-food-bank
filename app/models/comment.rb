class Comment < ApplicationRecord

  belongs_to :delivery_request
  belongs_to :community_member, optional: true
  belongs_to :volunteer, optional: true

  include ActiveModel::Validations
  validates_with UserValidator
  validates :content, presence: true

  # TODO: build custom validation to ensure that a comment only has EITHER a memberID or volunteerID
  # because... a comment can only belong to one user

  # TODO: build a method that takes the "updated_at" time and makes it user-friendly
end
