class AddToFriendShipEligibleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :friendship_eligible, :boolean, null: false, default: false
  end
end
