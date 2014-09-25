class User < ActiveRecord::Base
  has_many :stories
  has_many :gifted_karmas, class_name: 'KarmaGift', foreign_key: 'giver_id'
  has_many :received_karmas, class_name: 'KarmaGift', foreign_key: 'receiver_id'

  validates :user_name, :password, presence: true
  validates :user_name, 
            uniqueness: true, 
            format: { with: /^[\w|_]{3,}$/, message: "only letters, numbers and underscores" }
  validates :email, 
            uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, 
            allow_blank: true
  validates :avatar_url, 
            format: { with: URI.regexp, message: 'Please enter a valid URL'},
            allow_blank: true
end