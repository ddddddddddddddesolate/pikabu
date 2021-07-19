module Mutations
  module Bookmarks
    class RemoveCommentFromBookmarks < BaseMutation
      argument :comment_id, ID, required: true

      field :message, String, null: false

      def resolve(comment_id:)
        comment = Comment.find(comment_id)

        current_user.bookmarks.find_by(bookmarkable: comment).destroy

        { message: 'success' }
      end
    end
  end
end