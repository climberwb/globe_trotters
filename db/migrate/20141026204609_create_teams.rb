class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :captain_id
      t.string  :name
      t.string  :sport
      t.string  :location
      
    end
  end
end
