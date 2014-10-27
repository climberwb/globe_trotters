class RemoveCaptainIdToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :captain_id, :integer
  end
end
