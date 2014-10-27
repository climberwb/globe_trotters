class AddCaptainToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :captain, index: true
  end
end
