# frozen_string_literal: true

module Types
  class ReactionsType < BaseEnum
    value "DISLIKE", value: Reaction::DISLIKE
    value "LIKE", value: Reaction::LIKE
  end
end
