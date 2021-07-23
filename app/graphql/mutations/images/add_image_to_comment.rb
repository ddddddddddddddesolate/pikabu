module Mutations
  module Images
    class AddImageToComment < BaseMutation
      argument :comment_id, ID, required: true
      argument :image_url, String, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(comment_id:, image_url:)
        comment = Comment.find_by(id: comment_id)

        raise GraphQL::ExecutionError, "Comment not found" unless comment.present?
        raise GraphQL::ExecutionError, "You cannot add image to this comment" unless comment.user_id == current_user.id

        image = comment.images.new(remote_image_url: image_url)

        if image.save
          {comment: comment}
        else
          {errors: image.errors.full_messages}
        end
      end
    end
  end
end
