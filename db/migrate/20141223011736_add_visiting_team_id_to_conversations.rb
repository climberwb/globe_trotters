class AddVisitingTeamIdToConversations < ActiveRecord::Migration
  def change
    change_table :conversations do |t|
      t.references :visiting_team
    end
  end
end
