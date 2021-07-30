# frozen_string_literal: true

module Mutations
  module Bookmarks
    class AddPostToBookmarksMutation < AuthorizedMutation
      argument :post_id, ID, required: true

      field :success, Boolean, null: false

      def resolve(post_id:)
        post = Post.find_by(id: post_id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        result = BookmarkManager::CreateBookmarkService.call(current_user, post)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
