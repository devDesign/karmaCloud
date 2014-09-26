class AddUserNameToStory < ActiveRecord::Migration
  def change
    add_column :stories, :user_name, :string
  end
end
