class AddTimestamps < ActiveRecord::Migration
  def change
    add_timestamps :users
    add_timestamps :stories
  end
end
