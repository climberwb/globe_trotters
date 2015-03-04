class CreateTeammateRelationships < ActiveRecord::Migration
  def change
    create_table :teammate_relationships do |t|
      t.timestamp :accepted_at
      t.references :sender, index: true
      t.references :receiver, index: true
      t.references :team_relationship, index: true
      t.timestamps
    end
  end
end
