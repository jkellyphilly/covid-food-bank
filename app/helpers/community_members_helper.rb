module CommunityMembersHelper

  def include_view_deliveries_member(member)
    if member.is_logged_in(session)
      render partial: "helpers/view_deliveries", locals: {type: 'community-members', user_id: member.id}
    end
  end

  def include_edit_option_member(member)
    if member.is_logged_in(session)
      render partial: "helpers/edit_profile", locals: {type: 'community-members', user_id: member.id}
    end
  end

  def include_todays_confirmed_deliveries(member)
    unless member.todays_confirmed_requests.size == 0
      render partial: "helpers/include_today", locals: {keyword: 'confirmed', user_id: member.id}
    end
  end

  def include_todays_completed_deliveries(member)
    unless member.todays_completed_requests.size == 0
      render partial: "helpers/include_today", locals: {keyword: 'completed', user_id: member.id}
    end
  end

  def display_todays_requests(requests)
    if requests.size == 0
      render partial: 'helpers/none_today'
    else
      render partial: 'helpers/todays_requests', locals: {requests: requests}
    end
  end

end
