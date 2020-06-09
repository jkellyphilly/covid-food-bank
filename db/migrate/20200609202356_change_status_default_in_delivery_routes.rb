class ChangeStatusDefaultInDeliveryRoutes < ActiveRecord::Migration[6.0]
  def change
    change_column :delivery_routes, :status, :string, :default => "confirmed"
  end
end
