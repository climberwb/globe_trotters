class AddVidconferenceIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :vidconference, index: true
  end
end
