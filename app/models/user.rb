class User < ActiveRecord::Base
  has_many :stories
  has_many :gifted_karmas, class_name: 'KarmaGift', foreign_key: 'giver_id'
  has_many :received_karmas, class_name: 'KarmaGift', foreign_key: 'receiver_id'
end