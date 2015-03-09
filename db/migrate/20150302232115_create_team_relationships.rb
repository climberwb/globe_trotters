class CreateTeamRelationships < ActiveRecord::Migration
  def change
    create_table :team_relationships do |t|
      t.timestamp :accepted_at
      t.timestamp :rejected_at
      t.references :sender_team, index: true
      t.references :receiver_team, index: true
      t.timestamps
    end
  end
end
