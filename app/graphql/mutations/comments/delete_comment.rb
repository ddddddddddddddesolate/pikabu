module Mutations
  module Comments
    class DeleteComment < BaseMutation
      argument :comment_id, ID, required: true

      field :message, String, null: false

      def resolve(comment_id:)
        comment = current_user.comments.find(comment_id)

        comment.destroy

        {message: "success"}
      end
    end
  end
end
