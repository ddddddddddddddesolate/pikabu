module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
    field :login_user, mutation: Mutations::LoginUser
    field :logout_user, mutation: Mutations::LogoutUser
    field :create_post, mutation: Mutations::CreatePost
    field :create_tag, mutation: Mutations::CreateTag
  end
end
