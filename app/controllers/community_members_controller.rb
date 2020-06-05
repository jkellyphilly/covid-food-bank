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
    @community_member = CommunityMember.create(member_params)
    binding.pry
    if @community_member.valid?
      redirect_to community_member_path(@community_member)
    else
      render :'community_members/new'
    end
  end

  private

  def find_member
    @community_member = CommunityMember.find(params[:id])
  end

  def member_params
    params.require(:community_member).permit(:name, :address, :phone_number, :email, :allergies, :password)
  end

end
