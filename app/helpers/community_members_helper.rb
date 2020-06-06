module CommunityMembersHelper

  def includeEditOption(member)
    if member.isLoggedIn
      puts "HELLO"
      render partial: "helpers/edit_profile", locals: {type: 'community-member', user_id: member.id}
    end
  end

end
