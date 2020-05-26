class AddDeliveryRequestIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :delivery_request_id, :integer
    add_column :comments, :volunteer_id, :integer
    add_column :comments, :community_member_id, :integer
  end
end
