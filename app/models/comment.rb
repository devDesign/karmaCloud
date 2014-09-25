class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :user_id, :story_id, :content, presence: true
end