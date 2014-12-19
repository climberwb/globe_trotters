class RemoveTeamIdFromConversations < ActiveRecord::Migration
  def change
    remove_column :conversations, :references, :team_id
  end
end
