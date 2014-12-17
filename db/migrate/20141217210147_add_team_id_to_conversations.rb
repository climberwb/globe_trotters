class AddTeamIdToConversations < ActiveRecord::Migration
  def change
    change_table :conversations do |t|
      t.references :team
    end
  end
end
