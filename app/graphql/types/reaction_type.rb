module Types
  class ReactionType < BaseObject
    field :user, UserType, null: false
    field :votable, ReactionableType, null: false
  end
end
