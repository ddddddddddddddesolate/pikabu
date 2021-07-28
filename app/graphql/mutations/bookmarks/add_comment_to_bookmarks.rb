# frozen_string_literal: true

module Mutations
  module Bookmarks
    class AddCommentToBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:)
        comment = BookmarkManager::CreateBookmarkService.call(
          current_user, Comment.includes(:user, :images, reactions: [:user]), id
        )

        { comment: comment }
      end
    end
  end
end
