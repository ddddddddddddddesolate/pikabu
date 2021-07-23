module Mutations
  module Images
    class RemoveImageFromPost < BaseMutation
      argument :post_id, ID, required: true
      argument :image_id, ID, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(post_id:, image_id:)
        post = Post.find_by(id: post_id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?
        raise GraphQL::ExecutionError, "You cannot remove image from this post" unless post.user_id == current_user.id

        image = Image.find_by(id: image_id)

        raise GraphQL::ExecutionError, "Image not found" unless image.present?
        raise GraphQL::ExecutionError, "Post doesn't contain this image" unless post.images.exists?(imageable: image)

        image.destroy

        if image.destroyed?
          {post: post}
        else
          {errors: image.errors.full_messages}
        end
      end
    end
  end
end
