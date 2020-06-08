module DeliveryRequestsHelper

  # TODO: get this helper method defined and working HERE
  # def printDeliveryTitle(dr)
  #   binding.pry
  # end

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

  def includeSignUpOption(dr)
    if(session[:user_type] == 'volunteers')
      render partial: 'volunteer_sign_up', locals: {dr_id: dr.id}
    end
  end

end
