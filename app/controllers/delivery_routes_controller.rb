class DeliveryRoutesController < ApplicationController

  # TODO: add a list of items per route (since the volunteer will need to buy it all?)

  def show
    @delivery_route = DeliveryRoute.find(params[:id])
  end

  def index
    if(params[:volunteer_id])
      @volunteer = Volunteer.find(params[:volunteer_id])
      @upcoming_routes = @volunteer.upcoming_delivery_routes
      @completed_routes = @volunteer.completed_delivery_routes
    end
  end

end
