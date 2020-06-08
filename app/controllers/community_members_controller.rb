class CommunityMembersController < ApplicationController

  before_action :find_member, only: [:show, :edit, :update]

  def index
    @community_members = CommunityMember.all
  end

  def new
    @community_member = CommunityMember.new
  end

  def create
    @community_member = CommunityMember.create(member_params)
    if @community_member.valid?
      session[:username] = @community_member.username
      session[:user_type] = 'community-members'
      redirect_to community_member_path(@community_member)
    else
      render :'community_members/new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @community_member.update(member_params)
    if @community_member.valid?
      redirect_to community_member_path(@community_member)
    else
      render :"community_members/edit"
    end
  end

  def login
  end

  private

  def find_member
    @community_member = CommunityMember.find(params[:id])
  end

  def member_params
    params.require(:community_member).permit(:name, :address, :phone_number, :email, :allergies, :username, :password)
  end

end
