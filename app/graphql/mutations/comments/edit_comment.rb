module Mutations
  module Comments
    class EditComment < BaseMutation
      argument :comment_id, ID, required: true
      argument :text, String, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(comment_id:, text:)
        comment = Comment.find_by(id: comment_id)

        raise GraphQL::ExecutionError, "Comment not found" unless comment.present?
        raise GraphQL::ExecutionError, "You cannot edit this comment" unless comment.user_id == current_user.id

        if comment.update(text: text)
          {comment: comment}
        else
          {errors: comment.errors.full_messages}
        end
      end
    end
  end
end
