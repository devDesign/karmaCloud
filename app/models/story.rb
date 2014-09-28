class Story < ActiveRecord::Base
  belongs_to :user
  has_many   :comments

  validates :content, :user_id, :user_name, presence: true
  validates :mood, format: { with: /\Ared|green\Z/, message: "must be 'red' or 'green'"}

end