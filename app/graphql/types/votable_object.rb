module Types
  class VotableObject < BaseObject
    field :likes_count, Integer, null: false, resolver: Resolvers::LikesCountResolver
    field :dislikes_count, Integer, null: false, resolver: Resolvers::DislikesCountResolver
  end
end