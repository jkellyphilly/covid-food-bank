module CommunityMembersHelper

  def includeEditOption(member)
    if member.isLoggedIn
      render partial: "helpers/edit_profile", locals: {type: 'community-members', user_id: member.id}
    end
  end

end
