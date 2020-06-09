class DeliveryRoutesController < ApplicationController

  before_action :get_route, only: [:show, :edit]
  before_action :get_volunteer
  # TODO: add a list of items per route (since the volunteer will need to buy it all?)

  def show
  end

  def index
    @upcoming_routes = @volunteer.upcoming_delivery_routes
    @completed_routes = @volunteer.completed_delivery_routes
  end

  def edit
    binding.pry
  end

  private

  def get_route
    @delivery_route = DeliveryRoute.find(params[:id])
  end

  def get_volunteer
    @volunteer = Volunteer.find(params[:volunteer_id])
  end

end
