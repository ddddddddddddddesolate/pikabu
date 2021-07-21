class Vote < ApplicationRecord
  LIKE = 1
  DISLIKE = 0

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :votable_id, uniqueness: { scope: [:user_id, :votable_id, :votable_type],
                                       message: 'object already rated'}
end
