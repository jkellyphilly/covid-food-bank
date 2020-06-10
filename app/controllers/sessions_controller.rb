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
      user_info = request.env['omniauth.auth']["info"]
      user_username = user_info["nickname"]
      user_name = user_info["name"]
      user_email = user_info["email"]

      if (session[:user_type] == 'community-members')
        @community_member = CommunityMember.find_or_create_by(username: user_username, email: user_email)
        if @community_member.valid?
          session[:user_id] = @community_member.id
          session[:message] = "Please note that if you change your username/email here, you won't be able to log in with your Github account unless your user ID and email from there match what we have in our records."
          redirect_to community_member_path(@community_member)
        else
          @community_member.name = user_name
          @community_member.email = user_email
          @community_member.password = Password.random 15
          @community_member.save
          session[:user_id] = @community_member.id
          session[:message] = "Welcome to the community! Please note that if you change your username/email here, you won't be able to log in with your Github account unless your user ID and email from there match what we have in our records here."
          redirect_to community_member_path(@community_member)
        end
      elsif (session[:user_type] == 'volunteers')
        binding.pry
      else
        session[:message] = "Login from third party site failed."
        redirect_to "/"
      end
    end
  end

  def destroy
    session.delete :user_id
    session.delete :user_type
    redirect_to '/'
  end

end
