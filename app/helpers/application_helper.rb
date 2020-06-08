module ApplicationHelper

  def printDeliveryTitle(dr)
    if (@community_member)
      render partial: 'helpers/print_delivery_title', locals: { delivery_request: dr, path: community_member_delivery_request_path(@community_member, dr)}
    else
      render partial: 'helpers/print_delivery_title', locals: { delivery_request: dr, path: delivery_request_path(dr) }
    end
  end

  def includeSignUpOption(dr)
    if(session[:user_type] == 'volunteers')
      render partial: 'volunteer_sign_up', locals: {dr_id: dr.id}
    end
  end

  # def newDeliveryRequestWording
  #   if (@community_member)
  #     render partial: 'new_delivery_wording', locals: {
  #       addressee: @community_member.name,
  #       path: new_community_member_delivery_request_path(@community_member)
  #     }
  #   else
  #     render partial: 'new_delivery_wording', locals: {
  #       addressee: "Community members",
  #       path: new_delivery_request_path
  #     }
  #   end
  # end

end
