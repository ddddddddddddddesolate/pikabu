module Mutations
  module Bookmarks
    class AddCommentToBookmarks < BaseMutation
      argument :comment_id, ID, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(comment_id:)
        comment = Comment.find_by(id: comment_id)

        raise GraphQL::ExecutionError, "Comment not found" unless comment.present?
        raise GraphQL::ExecutionError, "Comment already in bookmarks" if current_user.bookmarks.exists?(bookmarkable: comment)

        bookmark = current_user.bookmarks.new(bookmarkable: comment)

        if bookmark.save
          {comment: comment}
        else
          {errors: bookmark.errors.full_messages}
        end
      end
    end
  end
end
