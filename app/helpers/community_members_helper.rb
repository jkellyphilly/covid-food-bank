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

end
