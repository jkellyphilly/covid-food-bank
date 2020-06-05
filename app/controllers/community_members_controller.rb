class CommunityMembersController < ApplicationController

  def index
    @community_members = CommunityMember.all
  end

end
