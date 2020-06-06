class SessionsController < ApplicationController

  def create
    binding.pry
    if params[:user_type] == "community-members"
      @community_member = CommunityMember.find_by(username: params[:username])
      if @community_member && @community_member.authenticate(params[:password])
        session[:username] = @community_member.username
        session[:user_type] = 'community-members'
      else
        # TODO: define error state
      end
    else
      binding.pry
    end
  end

  def destroy
    session.delete :username
    session.delete :user_type
    redirect_to '/welcome'
  end

end
