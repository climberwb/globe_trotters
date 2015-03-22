class CreateIndividualRelationships < ActiveRecord::Migration
  def change
    create_table :individual_relationships do |t|
      t.timestamp :accepted_at
      t.timestamp :rejected_at
      t.references :sender, index: true
      t.references :receiver, index: true
      t.timestamps
    end
  end
end
