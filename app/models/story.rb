class Story < ActiveRecord::Base
  belongs_to :user
  has_many   :comments

  validates :title, :content, :user_id, presence: true
  validates :mood, format: { with: /\Ared|green\Z/, message: "must be 'red' or 'green'"}

  geocoded_by      :location
  after_validation :geocode
end