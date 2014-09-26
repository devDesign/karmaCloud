class User < ActiveRecord::Base
  has_many :stories
  has_many :gifted_karmas, class_name: 'KarmaGift', foreign_key: 'giver_id'
  has_many :received_karmas, class_name: 'KarmaGift', foreign_key: 'receiver_id'

  validates :user_name, :password, presence: true
  validates :user_name, 
            uniqueness: true, 
            format: { with: /\A[\w|_.]{3,}\Z/, message: "only letters, numbers, periodes and underscores" }
  validates :email, 
            uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, 
            allow_blank: true
  validates :avatar_url, 
            format: { with: URI.regexp, message: 'Please enter a valid URL'},
            allow_blank: true

  def give_karma(amount)
    return false if amount > karma_bank
    self.karma_bank -= amount
  end

  def receive_karma(amount)
    self.karma_bank  += amount
    self.karma_total += amount
  end
end