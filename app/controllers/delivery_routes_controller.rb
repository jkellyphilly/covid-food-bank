class DeliveryRoutesController < ApplicationController

  def show
    @delivery_route = DeliveryRoute.find(params[:id])
  end

end
