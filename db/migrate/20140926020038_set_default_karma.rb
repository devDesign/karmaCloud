class SetDefaultKarma < ActiveRecord::Migration
  def change
    change_column :users, :karma_total, :integer, default: 0
    change_column :users, :karma_bank, :integer, default: 0
  end
end
