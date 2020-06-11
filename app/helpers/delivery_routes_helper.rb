module DeliveryRoutesHelper

  def include_edit_option_route(route)
    if route.belongs_to_current_volunteer(session)
      render partial: "edit_route", locals: {vol_id: route.volunteer_id, route_id: route.id}
    end
  end

  def include_delete_option_route(route)
    if (route.belongs_to_current_volunteer(session) && route.is_valid_for_deletion)
      render partial: "delete_route", locals: {vol: route.volunteer, route: route}
    end
  end

end
