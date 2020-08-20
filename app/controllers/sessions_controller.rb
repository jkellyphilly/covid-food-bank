class SessionsController < ApplicationController

  def create
    if params[:user_type] == "community-members"
      # We know we're logging in from the community member login route.
      # Thus, find the community member and authenticate
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
      # We know we're logging in from the volunteer login route.
      # Thus, find the volunteer and authenticate
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
      # At this point, we must be logging in from Github (as of now, the only
      # other way to log in). Thus, depending on whether the individual is logging
      # in as a community member or volunteer, use the information from the response
      # for username to find the user in the database and log in as that user.
      # However, if a CM/VOL doesn't exist under that username, create a new CM/VOL
      # based on the respone's name & email. Generate a random password with the
      # Simple Password Generation gem, adn then log that person in. 
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
        @volunteer = Volunteer.find_or_create_by(username: user_username, email: user_email)
        if @volunteer.valid?
          session[:user_id] = @volunteer.id
          session[:message] = "Please note that if you change your username/email here, you won't be able to log in with your Github account unless your user ID and email from there match what we have in our records."
          redirect_to volunteer_path(@volunteer)
        else
          @volunteer.name = user_name
          @volunteer.email = user_email
          @volunteer.password = Password.random 15
          @volunteer.save
          session[:user_id] = @volunteer.id
          session[:message] = "Welcome to the community! Please note that if you change your username/email here, you won't be able to log in with your Github account unless your user ID and email from there match what we have in our records here."
          redirect_to volunteer_path(@volunteer)
        end
      else
        session[:message] = "Login from third party site failed."
        redirect_to "/"
      end
    end
  end

  # Delete the user_id and user_type from the session hash on logout
  def destroy
    session.delete :user_id
    session.delete :user_type
    redirect_to '/'
  end

end
