module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::CreatePost
    field :create_tag, mutation: Mutations::CreateTag
  end
end
