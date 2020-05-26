class CreateCommunityMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :community_members do |t|
      t.string :name
      t.string :username
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :allergies
      t.string :password_digest

      t.timestamps
    end
  end
end
