class RemoveAvatarUrl < ActiveRecord::Migration
  def change
    remove_column :stories, :avatar_url, :string
  end
end
