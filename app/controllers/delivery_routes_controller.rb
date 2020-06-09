class DeliveryRoutesController < ApplicationController

  before_action :get_route, only: [:show, :edit, :update]
  before_action :get_volunteer
  # TODO: add a list of items per route (since the volunteer will need to buy it all?)

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
      @delivery_route.updateAllStatuses
      redirect_to volunteer_delivery_route_path(@volunteer, @delivery_route)
    else
      binding.pry
    end
  end

  private

  def get_route
    @delivery_route = DeliveryRoute.find(params[:id])
  end

  def get_volunteer
    @volunteer = Volunteer.find(params[:volunteer_id])
  end

end
