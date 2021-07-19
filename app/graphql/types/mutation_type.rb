module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::Auth::RegisterUser
    field :login_user, mutation: Mutations::Auth::LoginUser
    field :logout_user, mutation: Mutations::Auth::LogoutUser
    field :create_post, mutation: Mutations::Posts::CreatePost
    field :update_post, mutation: Mutations::Posts::UpdatePost
    field :delete_post, mutation: Mutations::Posts::DeletePost
    field :create_tag, mutation: Mutations::Tags::CreateTag
    field :update_tag, mutation: Mutations::Tags::UpdateTag
    field :delete_tag, mutation: Mutations::Tags::DeleteTag
    field :add_tag_to_post, mutation: Mutations::PostsTags::AddTagToPost
    field :remove_tag_from_post, mutation: Mutations::PostsTags::RemoveTagFromPost
  end
end
