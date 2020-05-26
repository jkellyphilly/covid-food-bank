class Comment < ApplicationRecord

  belongs_to :delivery_request
  belongs_to :community_member
  belongs_to :volunteer
end
