class Story < ActiveRecord::Base
  belongs_to :user
  has_many   :comments

  validates :title, :content, presence: true
  validates :mood, format: { with: /^red|green$/, message: "must be 'red' or 'green'"}
end