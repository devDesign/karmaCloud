class AddUser < ActiveRecord::Migration
  def change
    create_table :user do |t|
      t.string  :user_name
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
