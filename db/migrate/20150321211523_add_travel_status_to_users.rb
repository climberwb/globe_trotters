class AddTravelStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :travel_status, :string
  end
end
