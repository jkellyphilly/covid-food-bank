module VolunteersHelper

  def include_edit_option_volunteer(volunteer)
    if volunteer.isLoggedIn(session)
      render partial: "helpers/edit_profile", locals: {type: 'volunteers', user_id: volunteer.id}
    end
  end

end
