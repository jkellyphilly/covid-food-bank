class SessionsController < ApplicationController

  def create
    binding.pry
    if params[:user_type] == "community-members"
      @community_member = CommunityMember.find_by(username: params[:username])
      if @community_member && @community_member.authenticate(params[:password])
        session[:username] = @community_member.username
        session[:user_type] = 'community-members'
        redirect_to community_member_path(@community_member)
      else
        # TODO: define error state
        # Incorrect username or password given
        binding.pry
      end
    elsif params[:user_type] == "volunteers"
      # check to see here what the other param types might be
      binding.pry
    else
      # what's the else condition here?
    end
  end

  def destroy
    session.delete :username
    session.delete :user_type
    redirect_to '/'
  end

end
