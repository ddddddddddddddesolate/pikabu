# frozen_string_literal: true

class Reaction < ApplicationRecord
  LIKE = 1
  DISLIKE = 0

  belongs_to :user
  belongs_to :reactionable, polymorphic: true

  validates :reaction,
            presence: true,
            allow_blank: false,
            numericality: { only_integer: true },
            inclusion: { in: [LIKE, DISLIKE] }
  validates :user_id, uniqueness: { scope: %w[reactionable_id reactionable_type] }

  counter_culture :reactionable, column_name: proc { |model|
    model.reaction == LIKE ? "likes_count" : "dislikes_count"
  }, touch: true
end
