module Types
  class VoteType < BaseObject
    field :user, UserType, null: false
    field :votable, VotableType, null: false
  end
end
