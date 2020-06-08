class DeliveryRequestsController < ApplicationController

  def index
    @delivery_requests = DeliveryRequest.all
  end

end
