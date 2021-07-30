# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::Auth::RegisterUserMutation
    field :login_user, mutation: Mutations::Auth::LoginUserMutation
    field :logout_user, mutation: Mutations::Auth::LogoutUserMutation
    field :create_post, mutation: Mutations::Posts::CreatePostMutation
    field :update_post, mutation: Mutations::Posts::UpdatePostMutation
    field :delete_post, mutation: Mutations::Posts::DeletePostMutation
    field :create_tag, mutation: Mutations::Tags::CreateTagMutation
    field :rename_tag, mutation: Mutations::Tags::RenameTagMutation
    field :delete_tag, mutation: Mutations::Tags::DeleteTagMutation
    field :add_tags_to_post, mutation: Mutations::PostsTags::AddTagsToPostMutation
    field :remove_tags_from_post, mutation: Mutations::PostsTags::RemoveTagsFromPostMutation
    field :add_comment_to_post, mutation: Mutations::Comments::AddCommentToPostMutation
    field :update_comment, mutation: Mutations::Comments::UpdateCommentMutation
    field :delete_comment, mutation: Mutations::Comments::DeleteCommentMutation
    field :reply_to_comment, mutation: Mutations::Comments::ReplyToCommentMutation
    field :add_post_to_bookmarks, mutation: Mutations::Bookmarks::AddPostToBookmarksMutation
    field :remove_post_from_bookmarks, mutation: Mutations::Bookmarks::RemovePostFromBookmarksMutation
    field :add_comment_to_bookmarks, mutation: Mutations::Bookmarks::AddCommentToBookmarksMutation
    field :remove_comment_from_bookmarks, mutation: Mutations::Bookmarks::RemoveCommentFromBookmarksMutation
    field :rate_post, mutation: Mutations::Reactions::RatePostMutation
    field :rate_comment, mutation: Mutations::Reactions::RateCommentMutation
    field :unrate_post, mutation: Mutations::Reactions::UnratePostMutation
    field :unrate_comment, mutation: Mutations::Reactions::UnrateCommentMutation
    field :add_image_to_post, mutation: Mutations::Images::AddImageToPostMutation
    field :delete_image_from_post, mutation: Mutations::Images::DeleteImageFromPostMutation
    field :add_image_to_comment, mutation: Mutations::Images::AddImageToCommentMutation
    field :delete_image_from_comment, mutation: Mutations::Images::DeleteImageFromCommentMutation
  end
end
