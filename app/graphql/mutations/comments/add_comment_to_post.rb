module Mutations
  module Comments
    class AddCommentToPost < BaseMutation
      argument :post_id, ID, required: true
      argument :text, String, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(post_id:, text:)
        post = Post.find(post_id)
        comment = post.comments.new(
          user_id: current_user.id,
          text: text
        )

        if comment.save
          { post: post }
        else
          { errors: comment.errors.full_messages }
        end
      end
    end
  end
end
