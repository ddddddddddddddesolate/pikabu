# frozen_string_literal: true

module Types
  class PostType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :title, String, null: false
    field :text, String, null: true
    field :tags, [TagType], null: true
    field :comments, [CommentType], null: true, resolver: Resolvers::PostRootCommentsResolver
    field :comments_count, Integer, null: false, resolver: Resolvers::CommentsCountResolver
    field :likes_count, Integer, null: false, resolver: Resolvers::LikesCountResolver
    field :dislikes_count, Integer, null: false, resolver: Resolvers::DislikesCountResolver
    field :votes, [ReactionType], null: false
    field :images, [ImageType], null: false
  end
end
