class DeliveryRoutesController < ApplicationController

  before_action :require_login
  before_action :get_route, only: [:show, :edit, :update, :destroy]
  before_action :get_volunteer
  before_action :require_current_volunteer, only: [:edit]

  def show
  end

  def index
    @upcoming_routes = @volunteer.upcoming_delivery_routes
    @completed_routes = @volunteer.completed_delivery_routes
  end

  def edit
  end

  def update
    @delivery_route.update(status: params[:status])
    if @delivery_route.valid?
      @delivery_route.update_all_statuses(@delivery_route.status)
      redirect_to volunteer_delivery_route_path(@volunteer, @delivery_route)
    else
      binding.pry
    end
  end

  def destroy
    @delivery_route.update_all_statuses("new")
    @delivery_route.destroy
    session[:message] = "Route has been deleted from your profile."
    redirect_to volunteer_path(@volunteer)
  end

  private

  def require_login
    unless session.include? :user_id
      session[:message] = "Error: You must be logged in to view information about our Community. Join us!"
      redirect_to '/'
    end
  end

  def get_route
    @delivery_route = DeliveryRoute.find(params[:id])
  end

  def get_volunteer
    @volunteer = Volunteer.find(params[:volunteer_id])
  end

  def require_current_volunteer
    unless((@volunteer.id == session[:user_id]) && (session[:user_type] == 'volunteers'))
      session[:message] = "You can only edit details of your own route."
      redirect_to volunteer_delivery_route_path(@volunteer, @delivery_route)
    end
  end

end
