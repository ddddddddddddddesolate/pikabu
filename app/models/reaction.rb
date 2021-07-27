# frozen_string_literal: true

class Reaction < ApplicationRecord
  LIKE = 1
  DISLIKE = 0

  belongs_to :user
  belongs_to :reactionable, polymorphic: true
end
