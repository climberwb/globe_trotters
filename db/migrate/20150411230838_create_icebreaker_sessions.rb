class CreateIcebreakerSessions < ActiveRecord::Migration
  def change
    create_table :icebreaker_sessions do |t|
      t.references :question, index: true
      t.references :notebook, index: true
      t.timestamps
    end
  end
end
