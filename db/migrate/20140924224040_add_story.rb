class AddStory < ActiveRecord::Migration
  def change
    create_table :story do |t|
      t.string  :title
      t.string  :password
      t.string  :name
      t.string  :email
      t.string  :lat
      t.string  :lon
      t.string  :avatar_url
      t.integer :karma_total
      t.integer :karma_bank
    end
  end
end
