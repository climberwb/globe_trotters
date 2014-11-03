class AddCaptainIdToTeam < ActiveRecord::Migration
  def change
    change_table :teams do |t|
      t.references :captain
    end
  end
end
