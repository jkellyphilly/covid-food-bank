class AddStatusToDeliveryRoutes < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_routes, :status, :string, :default => "new"
  end
end
