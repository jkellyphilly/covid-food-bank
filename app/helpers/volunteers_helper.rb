module VolunteersHelper

  def includeEditOption(volunteer)
    if volunteer.isLoggedIn
      render partial: "helpers/edit_profile", locals: {type: 'volunteers', user_id: volunteer.id}
    end
  end

end
