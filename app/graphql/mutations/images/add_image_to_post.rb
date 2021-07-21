module Mutations
  module Images
    class AddImageToPost < BaseMutation
      argument :post_id, ID, required: true
      argument :image_url, String, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(post_id:, image_url:)
        post = Post.find(post_id)

        image = post.images.new(remote_image_url: image_url)

        if image.save
          {post: post}
        else
          {errors: image.errors}
        end
      end
    end
  end
end
