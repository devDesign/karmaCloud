class ChangeLocationColumnNames < ActiveRecord::Migration
  def change
    rename_column :users, :lat, :latitude
    rename_column :users, :lon, :longitude
    rename_column :stories, :lat, :latitude
    rename_column :stories, :lon, :longitude
  end
end
