class AddTeamIdToConversations < ActiveRecord::Migration
  def change
    change_table :conversations do |t|
      t.references :team_id
    end
  end
end
