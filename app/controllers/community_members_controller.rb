class CommunityMembersController < ApplicationController
  before_action :find_member, only: [:show]

  def index
    @community_members = CommunityMember.all
  end

  def new
    @community_member = CommunityMember.new
  end

  def show
  end

  def create
    binding.pry
  end

  private

  def find_member
    @community_member = CommunityMember.find(params[:id])
  end

end
