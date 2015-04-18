class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      #t.references :user, index: true #this is not needed now that notebook is under user
      t.references :icebreaker_session, index: true
      t.timestamps
    end
  end
end
