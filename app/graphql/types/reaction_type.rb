module Types
  class ReactionType < BaseObject
    field :user, UserType, null: false
    field :reactionable, ReactionableType, null: false
  end
end
