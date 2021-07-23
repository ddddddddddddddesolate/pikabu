module Mutations
  module Comments
    class DeleteComment < BaseMutation
      argument :comment_id, ID, required: true

      field :message, String, null: false

      def resolve(comment_id:)
        comment = Comment.find_by(id: comment_id)

        raise GraphQL::ExecutionError, "Comment not found" unless comment.present?
        raise GraphQL::ExecutionError, "You cannot delete this comment" unless comment.user_id == current_user.id

        comment.destroy

        {message: "success"}
      end
    end
  end
end
