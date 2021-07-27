# frozen_string_literal: true

module Types
  class Reactions < BaseEnum
    value 'DISLIKE', value: Reaction::DISLIKE
    value 'LIKE', value: Reaction::LIKE
  end
end
