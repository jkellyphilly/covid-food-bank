module VolunteersHelper

  def include_edit_option_volunteer(volunteer)
    if volunteer.is_logged_in(session)
      render partial: "helpers/edit_profile", locals: {type: 'volunteers', user_id: volunteer.id}
    end
  end

end
