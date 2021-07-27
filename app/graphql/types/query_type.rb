# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :posts, [PostType], null: true, resolver: Resolvers::PostsResolver
    field :comments, [CommentType], null: true, resolver: Resolvers::CommentsResolver
    field :bookmarks, [BookmarkType], null: true, resolver: Resolvers::BookmarksResolver
  end
end
