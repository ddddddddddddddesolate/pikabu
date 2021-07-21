module Types
  class CommentType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :post, PostType, null: false
    field :text, String, null: false
    field :comment, CommentType, null: true
    field :comments, [CommentType], null: true
    field :replies_count, Integer, null: false, resolver: Resolvers::CommentsCountResolver
    field :likes_count, Integer, null: false, resolver: Resolvers::LikesCountResolver
    field :dislikes_count, Integer, null: false, resolver: Resolvers::DislikesCountResolver
    field :votes, VoteType, null: false
  end
end
