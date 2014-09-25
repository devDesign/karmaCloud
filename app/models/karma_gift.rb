class KarmaGift < ActiveRecord::Base
  belongs_to :giver, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  validates :giver_id, :receiver_id, presence: true
end