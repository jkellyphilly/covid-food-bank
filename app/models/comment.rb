class Comment < ApplicationRecord

  belongs_to :delivery_request
  belongs_to :community_member
  belongs_to :volunteer

  # TODO: build custom validation to ensure that a comment only has EITHER a memberID or volunteerID
  # because... a comment can only belong to one user
end
