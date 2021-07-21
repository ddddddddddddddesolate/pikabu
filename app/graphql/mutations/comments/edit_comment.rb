module Mutations
  module Comments
    class EditComment < BaseMutation
      argument :comment_id, ID, required: true
      argument :text, String, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(comment_id:, text:)
        comment = current_user.comments.find(comment_id)

        if comment.update(text: text)
          {comment: comment}
        else
          {errors: comment.errors.full_messages}
        end
      end
    end
  end
end
