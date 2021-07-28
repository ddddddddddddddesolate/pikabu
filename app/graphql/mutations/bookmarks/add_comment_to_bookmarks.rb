# frozen_string_literal: true

module Mutations
  module Bookmarks
    class AddCommentToBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:)
        comment = Comment.find(id)
        comment = BookmarkManager::CreateBookmarkService.call(current_user, comment)

        { comment: comment }
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::NotFoundError, 'Comment not found'
      end
    end
  end
end
