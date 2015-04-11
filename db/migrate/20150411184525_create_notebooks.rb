class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.references :individual_relationship, index: true
      t.timestamps
    end
  end
end
