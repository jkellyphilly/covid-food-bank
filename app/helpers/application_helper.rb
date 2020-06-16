module ApplicationHelper

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
