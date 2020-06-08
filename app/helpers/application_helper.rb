module ApplicationHelper

  def printDeliveryTitle(dr)
    if (@community_member)
      render partial: 'helpers/print_delivery_title', locals: { delivery_request: dr, path: community_member_delivery_request_path(@community_member, dr)}
    else
      render partial: 'helpers/print_delivery_title', locals: { delivery_request: dr, path: delivery_request_path(dr) }
    end
  end

  # TODO: should this be in this Helper?
  def includeSignUpOption(dr)
    if(session[:user_type] == 'volunteers')
      render partial: 'volunteer_sign_up', locals: {dr_id: dr.id}
    end
  end

  def showEditOptionDelivery(dr)
    binding.pry
    if dr.isValidForEdit(session[:user_type], session[:user_id])
      binding.pry
      render partial: 'edit_delivery_details', locals: {dr_id: dr.id}
    end
  end

end
