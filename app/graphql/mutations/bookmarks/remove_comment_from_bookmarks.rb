# frozen_string_literal: true

module Mutations
  module Bookmarks
    class RemoveCommentFromBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        comment = Comment.find(id)
        success = BookmarkManager::RemoveBookmarkService.call(current_user, comment)

        { success: success }
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::NotFoundError, 'Comment not found'
      end
    end
  end
end
