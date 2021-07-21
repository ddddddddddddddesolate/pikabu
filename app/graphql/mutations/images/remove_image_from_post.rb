module Mutations
  module Images
    class RemoveImageFromPost < BaseMutation
      argument :post_id, ID, required: true
      argument :image_id, ID, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(post_id:, image_id:)
        post = current_user.posts.find(post_id)
        image = post.images.find(image_id)

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
