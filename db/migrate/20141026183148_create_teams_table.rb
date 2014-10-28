class CreateTeamsTable < ActiveRecord::Migration
  def change
    create_table :team_tables do |t|
      t.integer :captain_id
    end
  end
end
