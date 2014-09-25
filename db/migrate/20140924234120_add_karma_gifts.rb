class AddKarmaGifts < ActiveRecord::Migration
  def change
    create_table :karma_gifts do |t|
      t.integer  :giver_id
      t.integer  :receiver_id
      t.integer  :amount
      t.timestamps
    end
  end
end
