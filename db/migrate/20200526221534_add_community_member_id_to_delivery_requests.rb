class AddCommunityMemberIdToDeliveryRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_requests, :community_member_id, :integer
    add_column :delivery_requests, :delivery_route_id, :integer
  end
end
