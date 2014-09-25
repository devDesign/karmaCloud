class Story < ActiveRecord::Base
  belongs_to :user
  has_many   :comments

  validates :title, :content, presence: true
  validates :mood, format: { with: /\Ared|green\Z/, message: "must be 'red' or 'green'"}
end