module Mutations
  module Images
    class RemoveImageFromComment < BaseMutation
      argument :comment_id, ID, required: true
      argument :image_id, ID, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(comment_id:, image_id:)
        comment = current_user.comments.find(comment_id)
        image = comment.images.find(image_id)

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
