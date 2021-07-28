# frozen_string_literal: true

class Reaction < ApplicationRecord
  LIKE = 1
  DISLIKE = 0

  belongs_to :user
  belongs_to :reactionable, polymorphic: true

  counter_culture :reactionable, column_name: proc { |model|
    model.reaction == LIKE ? 'likes_count' : 'dislikes_count'
  }, touch: true
end
