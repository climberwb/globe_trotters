class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user, null: false
      t.references :question, null: false
      t.boolean :pending, null: false, default: true
      t.text :content #, null: false
      t.timestamps null: false
    end
    add_index :answers, [:user_id, :question_id], unique: true
  end
end