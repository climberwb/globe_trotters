class AddHomeTeamIdToConversation < ActiveRecord::Migration
  def change
    change_table :conversations do |t|
      t.references :home_team
    end
  end
end
