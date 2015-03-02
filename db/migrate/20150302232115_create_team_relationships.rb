class CreateTeamRelationships < ActiveRecord::Migration
  def change
    create_table :team_relationships do |t|
      t.timestamp :accepted_at
      t.references :sender, index: true
      t.references :receiver, index: true
    end
  end
end
