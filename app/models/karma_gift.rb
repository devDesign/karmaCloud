class KarmaGift < ActiveRecord::Base
  belongs_to :giver, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'

  validates :giver_id, :receiver_id, :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  before_create :karma_transfer
  before_destroy do
    return false
  end

  private
  def karma_transfer
    return false unless User.find(giver_id).give_karma(amount)
    return false unless User.find(receiver_id).receive_karma(amount)
  end
end