module DeliveryRequestsHelper

  # TODO: get this helper method defined and working HERE
  # def printDeliveryTitle(dr)
  #   binding.pry
  # end

  # TODO: rename this to camel_case
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

end
