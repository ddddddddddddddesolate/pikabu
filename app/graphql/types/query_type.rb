module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :posts, [PostType], null: false
    field :tags, [TagType], null: false
    field :me, UserType, null: false

    def posts
      Post.all
    end

    def tags
      Tag.all
    end

    def me
      current_user
    end
  end
end
