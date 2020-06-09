module DeliveryRoutesHelper

  def includeEditOptionRoute(route)
    if route.belongsToCurrentVolunteer(session)
      render partial: "edit_route", locals: {vol_id: route.volunteer_id, route_id: route.id}
    end
  end

  def includeDeleteOptionRoute(route)
    if (route.belongsToCurrentVolunteer(session) && route.isValidForDeletion)
      render partial: "delete_route", locals: {vol: route.volunteer, route: route}
    end
  end

end
