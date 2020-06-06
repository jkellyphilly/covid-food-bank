class SessionsController < ApplicationController

  def create
    binding.pry
  end

  def destroy
    session.delete :username
    session.delete :user_type
    redirect_to '/welcome'
  end

end
