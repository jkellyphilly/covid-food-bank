class DeliveryRequestsController < ApplicationController

  before_action :require_login, except: [:new, :destroy]
  before_action :require_member_login, only: [:new, :destroy]
  before_action :find_request, only: [:show, :edit, :update, :volunteer, :destroy]
  before_action :require_edit_scenario, only: [:edit]

  def index
    if params[:community_member_id]
      # If we have community_member_id key in params, then we only want to show
      # the pending/confirmed/completed delivery requests for that member
      @community_member = CommunityMember.find(params[:community_member_id])
      @pending_delivery_requests = @community_member.pending_delivery_requests
      @confirmed_delivery_requests = @community_member.confirmed_delivery_requests
      @completed_delivery_requests = @community_member.completed_delivery_requests
    else
      # Otherwise, show all of the pending/confirmed/completed delivery requests
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
      @delivery_request.associate_member(session)

      session[:message] = "Way to go, #{@delivery_request.community_member.name}! Your request is now in our system and will be picked up by a volunteer."
      redirect_to delivery_request_path(@delivery_request)
    else
      render :'delivery_requests/new'
    end
  end

  def show
    if(params[:community_member_id])
      @community_member = CommunityMember.find(params[:community_member_id])
    end

    @new_comment = Comment.new
  end

  def edit
  end

  def update
    # If there's a status given in the status, set that as the previous_status variable
    if(params[:delivery_request][:status])
      previous_status = @delivery_request.status
    end

    @delivery_request.update(request_params)
    if @delivery_request.valid?
      if(previous_status)
        @delivery_request.update_status(previous_status, session[:user_id])
      end

      redirect_to delivery_request_path(@delivery_request)
    elsif (session[:user_type] == 'volunteers')
      # If a volunteer is trying to update the delivery request but it's not valid,
      # it must be because the date is passed.
      session[:message] = "Status is unable to be updated because the requested delivery date has passed. Leave a comment for the requesting member to update the requested date to a valid future date."
      redirect_to delivery_request_path(@delivery_request)
    else
      render :"delivery_requests/edit"
    end
  end

  def volunteer
    # Ensure that the delivery request can be edited from volunteer perspective
    unless @delivery_request.is_valid_for_volunteer(session)
      session[:message] = "Error: you can only edit the status of delivery requests that belong to your routes or that are not yet assigned to a route."
      redirect_to delivery_request_path(@delivery_request)
    end
  end

  def destroy
    @community_member = CommunityMember.find(session[:user_id])

    # Only allow community members to destroy their own delivery requests
    unless (@community_member.id == @delivery_request.community_member_id)
      session[:message] = "Error: You may only delete requests that belong to your profile."
      redirect_to '/delivery-requests'
    end

    # Delete all corresponding comments related to this request
    @delivery_request.comments.each { |c| c.destroy }

    @delivery_request.destroy
    session[:message] = "Successfully deleted delivery request from your profile."
    redirect_to community_member_path(@community_member)
  end

  private

  # Use strong params to ensure valid data is received
  def request_params
    params.require(:delivery_request).permit(:items, :requested_date, :status)
  end

  def find_request
    @delivery_request = DeliveryRequest.find(params[:id])
  end

  # Ensures that a login has occurred (and the session has has been updated accordingly)
  def require_login
    unless session.include? :user_id
      session[:message] = "Error: You must be logged in to view information about our Community. Join us!"
      redirect_to '/'
    end
  end

  def require_edit_scenario
    unless @delivery_request.is_valid_for_edit(session[:user_type], session[:user_id])
      session[:message] = "Error: You can only edit your own delivery requests before they are confirmed by a volunteer."
      redirect_to delivery_request_path(@delivery_request)
    end
  end

  # Specifically require a member to be logged in
  def require_member_login
    unless (session.include?(:user_id) && (session[:user_type] == "community-members"))
      session[:message] = "Error: You must be logged in as a community member to create a new or destroy an existing delivery request."
      redirect_to '/delivery-requests'
    end
  end

end
