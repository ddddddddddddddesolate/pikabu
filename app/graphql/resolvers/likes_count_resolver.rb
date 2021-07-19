module Resolvers
  class LikesCountResolver < BaseResolver
    type Integer, null: false

    def resolve
      Vote.where(votable: object, reaction: 1).count
    end
  end
end