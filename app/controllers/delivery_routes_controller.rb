class DeliveryRoutesController < ApplicationController

  # TODO: add a list of items per route (since the volunteer will need to buy it all?)

  def show
    @delivery_route = DeliveryRoute.find(params[:id])
  end

end
