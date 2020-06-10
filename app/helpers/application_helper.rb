module ApplicationHelper

  def printDeliveryTitle(dr)
    if (@community_member)
      render partial: 'helpers/print_delivery_title', locals: { delivery_request: dr, path: community_member_delivery_request_path(@community_member, dr)}
    else
      render partial: 'helpers/print_delivery_title', locals: { delivery_request: dr, path: delivery_request_path(dr) }
    end
  end

  def include_banner
    if(session[:user_id])
      render partial: "helpers/banner", locals: { user_type: session[:user_type], user_id: session[:user_id] }
    end
  end

  def include_flash_message
    if(session[:message])
      render partial: "helpers/flash_message", locals: { message: session[:message] }
      session.delete(:message)
    end
  end

end
