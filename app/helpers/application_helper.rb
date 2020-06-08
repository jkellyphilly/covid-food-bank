module ApplicationHelper

  def printDeliveryTitle(dr)
    if (@community_member)
      render partial: 'helpers/print_delivery_title', locals: { delivery_request: dr, path: community_member_delivery_request_path(@community_member, dr)}
    else
      render partial: 'helpers/print_delivery_title', locals: { delivery_request: dr, path: delivery_request_path(dr) }
    end
  end

end
