module CommunityMembersHelper

  def includeViewDeliveriesMember(member)
    if member.isLoggedIn(session)
      render partial: "helpers/view_deliveries", locals: {type: 'community-members', user_id: member.id}
    end
  end

  def include_edit_option_member(member)
    if member.isLoggedIn(session)
      render partial: "helpers/edit_profile", locals: {type: 'community-members', user_id: member.id}
    end
  end

end
