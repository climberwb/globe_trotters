class AddCaptainIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :captain_id, :integer
  end
end
