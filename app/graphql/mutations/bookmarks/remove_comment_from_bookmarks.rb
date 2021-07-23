module Mutations
  module Bookmarks
    class RemoveCommentFromBookmarks < BaseMutation
      argument :comment_id, ID, required: true

      field :message, String, null: false

      def resolve(comment_id:)
        comment = Comment.find_by(id: comment_id)

        raise GraphQL::ExecutionError, "Comment not found" unless comment.present?
        raise GraphQL::ExecutionError, "Comment not in bookmarks" unless current_user.bookmarks.exists?(bookmarkable: comment)

        current_user.bookmarks.find_by(bookmarkable: comment).destroy

        {message: "success"}
      end
    end
  end
end
