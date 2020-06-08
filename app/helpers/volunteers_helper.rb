module VolunteersHelper

  def includeEditOptionVolunteer(volunteer)
    if volunteer.isLoggedIn(session)
      render partial: "helpers/edit_profile", locals: {type: 'volunteers', user_id: volunteer.id}
    end
  end

end
