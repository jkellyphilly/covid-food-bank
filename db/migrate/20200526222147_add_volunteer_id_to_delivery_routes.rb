class AddVolunteerIdToDeliveryRoutes < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_routes, :volunteer_id, :integer
  end
end
