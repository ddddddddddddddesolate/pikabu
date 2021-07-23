module Mutations
  module Comments
    class LeaveComment < BaseMutation
      argument :post_id, ID, required: true
      argument :text, String, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(post_id:, text:)
        post = Post.find_by(id: post_id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?

        comment = post.comments.new(
          user_id: current_user.id,
          text: text
        )

        if comment.save
          {comment: comment}
        else
          {errors: comment.errors.full_messages}
        end
      end
    end
  end
end
