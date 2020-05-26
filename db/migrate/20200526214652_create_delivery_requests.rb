class CreateDeliveryRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_requests do |t|
      t.string :items
      t.string :requested_date
      t.string :status

      t.timestamps
    end
  end
end
