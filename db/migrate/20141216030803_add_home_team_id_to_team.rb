class AddHomeTeamIdToTeam < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.references :home_team
    end
  end
end
