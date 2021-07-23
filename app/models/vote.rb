class Vote < ApplicationRecord
  LIKE = 1
  DISLIKE = 0

  belongs_to :user
  belongs_to :votable, polymorphic: true
end
