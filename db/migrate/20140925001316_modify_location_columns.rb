class ModifyLocationColumns < ActiveRecord::Migration
  def up
    connection.execute(%q{
      ALTER TABLE users
      ALTER COLUMN lat
      type decimal using cast(lat as decimal)
    })

    connection.execute(%q{
      ALTER TABLE users
      ALTER COLUMN lon
      type decimal using cast(lon as decimal)
    })

    connection.execute(%q{
      ALTER TABLE stories
      ALTER COLUMN lat
      type decimal using cast(lat as decimal)
    })

    connection.execute(%q{
      ALTER TABLE stories
      ALTER COLUMN lon
      type decimal using cast(lon as decimal)
    })
  end

  def down
    change_column :users, :lat, :string
    change_column :users, :lon, :string
    change_column :stories, :lat, :string
    change_column :stories, :lon, :string
  end 
end
