class CommunityMembersController < ApplicationController
  before_action :find_member, only: [:show]

  def index
    @community_members = CommunityMember.all
  end

  def show
  end

  private

  def find_member
    @community_member = CommunityMember.find(params[:id])
  end

end
