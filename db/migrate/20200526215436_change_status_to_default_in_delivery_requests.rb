class ChangeStatusToDefaultInDeliveryRequests < ActiveRecord::Migration[6.0]
  def change
    change_column :delivery_requests, :status, :string, :default => "new"
  end
end
