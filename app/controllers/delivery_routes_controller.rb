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
      # If the updated route is valid, then update all of the statuses
      # of the delivery requests it contains
      @delivery_route.update_all_statuses(@delivery_route.status)
    else
      session[:message] = "Error: delivery route failed to update."
    end

    redirect_to volunteer_delivery_route_path(@volunteer, @delivery_route)
  end

  def destroy
    # When destroying a route, first update all of the statuses that belong to it to "new"
    @delivery_route.update_all_statuses("new")
    @delivery_route.destroy
    session[:message] = "Route has been deleted from your profile."
    redirect_to volunteer_path(@volunteer)
  end

  private

  # Ensures that a login has occurred (and the session has has been updated accordingly)
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

  # Used to ensure that a volunteer can only edit their own routes
  def require_current_volunteer
    unless((@volunteer.id == session[:user_id]) && (session[:user_type] == 'volunteers'))
      session[:message] = "You can only edit details of your own route."
      redirect_to volunteer_delivery_route_path(@volunteer, @delivery_route)
    end
  end

end
