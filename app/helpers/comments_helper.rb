module CommentsHelper

  def print_user_and_time(comment)
    if(comment.community_member_id)
      member = CommunityMember.find(comment.community_member_id)
      render partial: 'comment_header', locals: {username: member.username, time: comment.print_time, user_type: "community-members", user_id: member.id}
    else
      volunteer = Volunteer.find(comment.volunteer_id)
      render partial: 'comment_header', locals: {username: volunteer.username, time: comment.print_time, user_type: "volunteers", user_id: volunteer.id}
    end
  end

end
