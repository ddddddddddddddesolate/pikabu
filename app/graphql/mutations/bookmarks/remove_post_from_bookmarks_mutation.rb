# frozen_string_literal: true

module Mutations
  module Bookmarks
    class RemovePostFromBookmarksMutation < AuthorizedMutation
      argument :post_id, ID, required: true

      field :success, Boolean, null: false

      def resolve(post_id:)
        post = Post.find_by(id: post_id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        bookmark = current_user.bookmarks.find_by(bookmarkable: post)

        raise Exceptions::NotFoundError, "Bookmark not found" unless bookmark

        result = BookmarkManager::RemoveBookmarkService.call(bookmark)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
