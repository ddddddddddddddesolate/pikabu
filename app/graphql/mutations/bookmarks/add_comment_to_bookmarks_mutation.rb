# frozen_string_literal: true

module Mutations
  module Bookmarks
    class AddCommentToBookmarksMutation < AuthorizedMutation
      argument :comment_id, ID, required: true

      field :success, Boolean, null: false

      def resolve(comment_id:)
        comment = Comment.find_by(id: comment_id)

        raise Exceptions::NotFoundError, "Comment not found" unless comment

        result = BookmarkManager::CreateBookmarkService.call(current_user, comment)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
