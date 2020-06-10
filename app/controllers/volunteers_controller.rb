class VolunteersController < ApplicationController

  before_action :require_login, except: [:login, :new, :create]
  before_action :find_volunteer, only: [:show, :edit, :update]
  before_action :require_current_volunteer, only: [:edit]

  def index
    @volunteers = Volunteer.all
  end

  def new
    @volunteer = Volunteer.new
  end

  def create
    @volunteer = Volunteer.create(volunteer_params)
    if @volunteer.valid?
      session[:user_id] = @volunteer.id
      session[:user_type] = 'volunteers'
      session[:message] = "Successfully created volunteer profile. Welcome, #{@volunteer.name}!"
      redirect_to volunteer_path(@volunteer)
    else
      render :'volunteers/new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @volunteer.update(volunteer_params)
    if @volunteer.valid?
      session[:message] = "Successfully updated your profile."
      redirect_to volunteer_path(@volunteer)
    else
      render :"volunteers/edit"
    end
  end

  def login
    session[:user_type] = 'community-members'
  end

  private

  def require_login
    unless session.include? :user_id
      session[:message] = "Error: You must be logged in to view information about our Community. Join us!"
      redirect_to '/'
    end
  end

  def find_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def volunteer_params
    params.require(:volunteer).permit(:name, :phone_number, :email, :username, :password)
  end

  def require_current_volunteer
    unless ((session[:user_type] == 'volunteers') && (session[:user_id] == @volunteer.id))
      session[:message] = "Error: you can only edit your own profile."
      redirect_to volunteer_path(@volunteer)
    end
  end

end
