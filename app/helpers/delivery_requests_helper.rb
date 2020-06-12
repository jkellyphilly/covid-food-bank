module DeliveryRequestsHelper

  def newDeliveryRequestWording
    if (@community_member)
      render partial: 'new_delivery_wording', locals: {
        addressee: @community_member.name,
        path: new_community_member_delivery_request_path(@community_member)
      }
    else
      render partial: 'new_delivery_wording', locals: {
        addressee: "Community members",
        path: new_delivery_request_path
      }
    end
  end

  def include_sign_up_option(dr)
    if(session[:user_type] == 'volunteers')
      render partial: 'volunteer_sign_up', locals: {dr_id: dr.id}
    end
  end

  def show_edit_option_delivery(dr)
    if dr.is_valid_for_edit(session[:user_type], session[:user_id])
      render partial: 'edit_delivery_details', locals: {dr_id: dr.id}
    end
  end

  def show_volunteer_option_delivery(dr)
    if dr.is_valid_for_volunteer(session)
      render partial: 'volunteer_status_view', locals: {dr_id: dr.id}
    end
  end

  def include_delete_option_request(dr)
    if dr.is_valid_for_deletion
      render partial: 'delete_delivery_request', locals: {dreq: dr}
    end
  end

end
