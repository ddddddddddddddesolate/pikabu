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
    field :add_comment_to_post, mutation: Mutations::Comments::AddCommentToPost
    field :update_comment, mutation: Mutations::Comments::UpdateComment
    field :delete_comment, mutation: Mutations::Comments::DeleteComment
    field :reply_to_comment, mutation: Mutations::Comments::ReplyToComment
    field :add_post_to_bookmarks, mutation: Mutations::Bookmarks::AddPostToBookmarks
    field :remove_post_from_bookmarks, mutation: Mutations::Bookmarks::RemovePostFromBookmarks
    field :add_comment_to_bookmarks, mutation: Mutations::Bookmarks::AddCommentToBookmarks
    field :remove_comment_from_bookmarks, mutation: Mutations::Bookmarks::RemoveCommentFromBookmarks
    field :rate_post, mutation: Mutations::Reactions::RatePost
    field :rate_comment, mutation: Mutations::Reactions::RateComment
    field :unrate_post, mutation: Mutations::Reactions::UnratePost
    field :unrate_comment, mutation: Mutations::Reactions::UnrateComment
    field :add_image_to_post, mutation: Mutations::Images::AddImageToPost
    field :delete_image_from_post, mutation: Mutations::Images::DeleteImageFromPost
    field :add_image_to_comment, mutation: Mutations::Images::AddImageToComment
    field :delete_image_from_comment, mutation: Mutations::Images::DeleteImageFromComment
  end
end
