module Resolvers
  class DislikesCountResolver < BaseResolver
    type Integer, null: false

    def resolve
      Vote.where(votable: object, reaction: 0).count
    end
  end
end
