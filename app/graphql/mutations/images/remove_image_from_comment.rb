module Mutations
  module Images
    class RemoveImageFromComment < BaseMutation
      argument :comment_id, ID, required: true
      argument :image_id, ID, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(comment_id:, image_id:)
        comment = Comment.find_by(id: comment_id)

        raise GraphQL::ExecutionError, "Comment not found" unless comment.present?
        raise GraphQL::ExecutionError, "You cannot remove image from this comment" unless comment.user_id == current_user.id

        image = Image.find_by(id: image_id)

        raise GraphQL::ExecutionError, "Image not found" unless image.present?
        raise GraphQL::ExecutionError, "Comment doesn't contain this image" unless comment.images.exists?(imageable: image)

        image.destroy

        if image.destroyed?
          {comment: comment}
        else
          {errors: image.errors.full_messages}
        end
      end
    end
  end
end
