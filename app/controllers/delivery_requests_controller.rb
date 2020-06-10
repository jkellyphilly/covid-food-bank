class DeliveryRequestsController < ApplicationController

  before_action :require_login, except: [:new]
  before_action :require_member_login, only: [:new]
  before_action :find_request, only: [:show, :edit, :update, :volunteer]
  before_action :require_edit_scenario, only: [:edit]

  def index
    if params[:community_member_id]
      @community_member = CommunityMember.find(params[:community_member_id])
      @pending_delivery_requests = @community_member.pending_delivery_requests
      @confirmed_delivery_requests = @community_member.confirmed_delivery_requests
      @completed_delivery_requests = @community_member.completed_delivery_requests
    else
      @pending_delivery_requests = DeliveryRequest.pending
      @confirmed_delivery_requests = DeliveryRequest.confirmed
      @completed_delivery_requests = DeliveryRequest.completed
    end
  end

  def new
    @delivery_request = DeliveryRequest.new
  end

  def create
    @delivery_request = DeliveryRequest.create(request_params)

    if @delivery_request.valid?
      # Create member association for this delivery request
      @delivery_request.associateMember(session)

      session[:message] = "Way to go, #{@delivery_request.community_member.name}! Your request is now in our system and will be picked up by a volunteer."
      redirect_to delivery_request_path(@delivery_request)
    else
      render :'delivery_requests/new'
    end
  end

  def show
  end

  def edit
  end

  def update
    # TODO: clean up the logic here
    if(params[:delivery_request][:status])
      previous_status = @delivery_request.status
    end

    @delivery_request.update(request_params)
    if @delivery_request.valid?
      if(previous_status)
        @delivery_request.update_status(previous_status, session[:user_id])
      end

      redirect_to delivery_request_path(@delivery_request)
    else
      render :"delivery_requests/edit"
    end
  end

  def volunteer
  end

  private

  def request_params
    params.require(:delivery_request).permit(:items, :requested_date, :status)
  end

  def find_request
    @delivery_request = DeliveryRequest.find(params[:id])
  end

  def require_login
    unless session.include? :user_id
      session[:message] = "Error: You must be logged in to view information about our Community. Join us!"
      redirect_to '/'
    end
  end

  def require_edit_scenario
    unless @delivery_request.isValidForEdit(session[:user_type], session[:user_id])
      session[:message] = "Error: You can only edit your own delivery requests before they are confirmed by a volunteer."
      redirect_to delivery_request_path(@delivery_request)
    end
  end

  def require_member_login
    session[:message] = "Error: You must be logged in as a community member to create a new delivery request."
    redirect_to '/delivery-requests' unless (session.include?(:user_id) && (session[:user_type] == "community-members"))
  end

end
