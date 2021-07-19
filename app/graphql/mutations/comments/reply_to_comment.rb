module Mutations
  module Comments
    class ReplyToComment < BaseMutation
      argument :comment_id, ID, required: true
      argument :text, String, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(comment_id:, text:)
        parent_comment = Comment.find(comment_id)

        comment = parent_comment.comments.new(
          text: text,
          post_id: parent_comment.post_id,
          user_id: current_user.id
        )

        if comment.save
          { comment: comment }
        else
          { errors: comment.errors.full_messages }
        end
      end
    end
  end
end