module DeliveryRoutesHelper

  def includeEditOptionRoute(route)
    if route.belongsToCurrentVolunteer(session)
      binding.pry
      render partial: "edit_route", locals: {vol_id: route.volunteer_id, route_id: route.id}
    end
  end

end
