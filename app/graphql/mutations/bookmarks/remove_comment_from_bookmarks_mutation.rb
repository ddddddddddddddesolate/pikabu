# frozen_string_literal: true

module Mutations
  module Bookmarks
    class RemoveCommentFromBookmarksMutation < AuthorizedMutation
      argument :comment_id, ID, required: true

      field :success, Boolean, null: false

      def resolve(comment_id:)
        comment = Comment.find_by(id: comment_id)

        raise Exceptions::NotFoundError, "Comment not found" unless comment

        bookmark = current_user.bookmarks.find_by(bookmarkable: comment)

        raise Exceptions::NotFoundError, "Bookmark not found" unless bookmark

        result = BookmarkManager::RemoveBookmarkService.call(bookmark)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
