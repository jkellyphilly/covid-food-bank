class SessionsController < ApplicationController

  def create
    # binding.pry
    if params[:user_type] == "community-members"
      @community_member = CommunityMember.find_by(username: params[:username])
      if @community_member && @community_member.authenticate(params[:password])
        session[:user_id] = @community_member.id
        session[:user_type] = 'community-members'
        redirect_to community_member_path(@community_member)
      else
        # TODO: define error state
        # Incorrect username or password given
        binding.pry
      end
    elsif params[:user_type] == "volunteers"
      @volunteer = Volunteer.find_by(username: params[:username])
      if @volunteer && @volunteer.authenticate(params[:password])
        session[:user_id] = @volunteer.id
        session[:user_type] = 'volunteers'
        # binding.pry
        redirect_to volunteer_path(@volunteer)
      else
        # TODO: define error state
        # Incorrect username or password given
        binding.pry
      end
    else
      # what's the else condition here?
    end
  end

  def destroy
    session.delete :user_id
    session.delete :user_type
    redirect_to '/'
  end

end
