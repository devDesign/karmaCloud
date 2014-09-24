class AddComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :story
      t.string     :content
      t.timestamps
    end
  end
end
