module DeliveryRoutesHelper

  def includeEditOptionRoute(route)
    if route.belongsToCurrentVolunteer(session)
      render partial: "edit_route", locals: {vol_id: route.volunteer_id, route_id: route.id}
    end
  end

end
