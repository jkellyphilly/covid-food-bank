class SessionsController < ApplicationController

  def create
    if params[:user_type] == "community-members"
      @community_member = CommunityMember.find_by(username: params[:username])
      if @community_member && @community_member.authenticate(params[:password])
        session[:user_id] = @community_member.id
        session[:user_type] = 'community-members'
        redirect_to community_member_path(@community_member)
      else
        session[:message] = "Incorrect username and password. Please try again."
        redirect_to "/community-members/login"
      end
    elsif params[:user_type] == "volunteers"
      @volunteer = Volunteer.find_by(username: params[:username])
      if @volunteer && @volunteer.authenticate(params[:password])
        session[:user_id] = @volunteer.id
        session[:user_type] = 'volunteers'
        redirect_to volunteer_path(@volunteer)
      else
        session[:message] = "Incorrect username and password. Please try again."
        redirect_to "/volunteers/login"
      end
    else
      session[:message] = "Invalid login type occurred. Please try again."
      redirect_to "/"
    end
  end

  def destroy
    session.delete :user_id
    session.delete :user_type
    redirect_to '/'
  end

end
