class DeliveryRequestsController < ApplicationController
  before_action :find_request, only: [:show, :edit, :update]

  def index
    @delivery_requests = DeliveryRequest.all
  end

  def new
    @delivery_request = DeliveryRequest.new
  end

  def create
    @delivery_request = DeliveryRequest.create(request_params)

    # We can't use a hidden field to draw out the member,
    # so we have to define the association here
    @delivery_request.associateMember(session)

    binding.pry
    if @delivery_request.valid?
      redirect_to delivery_request_path(@delivery_request)
    else
      render :'delivery_requests/new'
    end
  end

  private

  def request_params
    params.require(:delivery_request).permit(:items, :requested_date)
  end

  def find_request
    @delivery_request = DeliveryRequest.find(params[:id])
  end

end
