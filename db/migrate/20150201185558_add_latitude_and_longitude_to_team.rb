class AddLatitudeAndLongitudeToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :latitude, :float#, null: false
    add_column :teams, :longitude, :float#, null: false
  end
end
