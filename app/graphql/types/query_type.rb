module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :posts, [PostType], null: true, resolver: Resolvers::PostsResolver
    field :comments, [CommentType], null: true, resolver:Resolvers::CommentsResolver
    field :bookmarks, [BookmarkType], null: true, resolver:Resolvers::BookmarksResolver
  end
end
