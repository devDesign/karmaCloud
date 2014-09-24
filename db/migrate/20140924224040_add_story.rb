class AddStory < ActiveRecord::Migration
  def change
    create_table :story do |t|
      t.string     :title
      t.string     :content
      t.string     :lat
      t.string     :lon
      t.string     :mood
      t.string     :avatar_url
      t.belongs_to :user
    end
  end
end
