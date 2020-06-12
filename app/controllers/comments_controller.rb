class CommentsController < ApplicationController

  def create
    @delivery_request = DeliveryRequest.find(params[:delivery_request_id])
    comment = Comment.create(content: params[:comment][:content], delivery_request_id: @delivery_request.id)

    if (session[:user_type] == 'community-members')
      @community_member = CommunityMember.find(session[:user_id])
      comment.community_member_id = @community_member.id
      comment.save
    else
      @volunteer = Volunteer.find(session[:user_id])
      comment.volunteer_id = @volunteer.id
      comment.save
    end

    if (params[:community_member_id])
      redirect_to community_member_delivery_request_path(@delivery_request.community_member, @delivery_request)
    else
      redirect_to delivery_request_path(@delivery_request)
    end
  end

end
