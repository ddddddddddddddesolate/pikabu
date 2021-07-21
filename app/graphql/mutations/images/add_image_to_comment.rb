module Mutations
  module Images
    class AddImageToComment < BaseMutation
      argument :comment_id, ID, required: true
      argument :image_url, String, required: true

      field :comment, Types::CommentType, null: true
      field :errors, [String], null: true

      def resolve(comment_id:, image_url:)
        comment = current_user.comments.find(comment_id)
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
