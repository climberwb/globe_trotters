class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.references :user, index: true
      t.timestamps
    end
  end
end
