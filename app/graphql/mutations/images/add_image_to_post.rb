module Mutations
  module Images
    class AddImageToPost < AuthorizedMutation
      argument :post_id, ID, required: true
      argument :image_url, String, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(post_id:, image_url:)
        post = Post.find_by(id: post_id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?
        raise GraphQL::ExecutionError, "You cannot add image to this post" unless post.user_id == current_user.id

        image = post.images.new(remote_image_url: image_url)

        if image.save
          {post: post}
        else
          {errors: image.errors.full_messages}
        end
      end
    end
  end
end
