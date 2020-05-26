class CreateDeliveryRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_routes do |t|
      t.string :estimated_delivery_date

      t.timestamps
    end
  end
end
