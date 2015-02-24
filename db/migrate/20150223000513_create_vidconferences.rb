class CreateVidconferences < ActiveRecord::Migration
  def change
    create_table :vidconferences do |t|
      t.string :session
    end
  end
end
