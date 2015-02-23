class CreateVideoConferences < ActiveRecord::Migration
  def change
    create_table :video_conferences do |t|
      t.string :session
    end
  end
end
