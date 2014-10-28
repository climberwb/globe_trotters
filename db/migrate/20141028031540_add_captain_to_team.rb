class AddCaptainToTeam < ActiveRecord::Migration
  def change
    add_reference :teams, :captain, index: true
  end
end
