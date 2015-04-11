class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      t.references :user, index: true
      t.references :icebreaker_session, index: true
      t.timestamps
    end
  end
end
