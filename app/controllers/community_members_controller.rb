class CommunityMembersController < ApplicationController

  before_action :require_login, except: [:login, :new, :create]
  before_action :find_member, only: [:show, :edit, :update, :todays_confirmed_requests]
  before_action :require_current_member, only: [:edit]

  def index
    @community_members = CommunityMember.all
  end

  def new
    @community_member = CommunityMember.new
  end

  def create
    @community_member = CommunityMember.create(member_params)
    if @community_member.valid?
      session[:user_id] = @community_member.id
      session[:user_type] = 'community-members'
      session[:message] = "Successfully created volunteer profile. Welcome, #{@community_member.name}!"
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
      session[:message] = "Successfully updated your profile."
      redirect_to community_member_path(@community_member)
    else
      render :"community_members/edit"
    end
  end

  def login
    session[:user_type] = 'community-members'
  end

  def todays_confirmed_requests
    @todays_confirmed_requests = @community_member.delivery_requests.today.confirmed
  end

  private

  def require_login
    unless session.include? :user_id
      session[:message] = "Error: You must be logged in to view information about our Community. Join us!"
      redirect_to '/'
    end
  end

  def find_member
    @community_member = CommunityMember.find(params[:id])
  end

  def member_params
    params.require(:community_member).permit(:name, :address, :phone_number, :email, :allergies, :username, :password)
  end

  def require_current_member
    unless ((session[:user_type] == 'community-members') && (session[:user_id] == @community_member.id))
      session[:message] = "Error: You can only edit your own profile."
      redirect_to community_member_path(@community_member)
    end
  end

end
