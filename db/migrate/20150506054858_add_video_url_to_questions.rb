class AddVideoUrlToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :video_url, :string, null: false, default: ""
  end
end
