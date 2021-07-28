# frozen_string_literal: true

module Types
  class ReactionType < BaseObject
    field :user, UserType, null: false
    field :reaction, Integer, null: false
  end
end
