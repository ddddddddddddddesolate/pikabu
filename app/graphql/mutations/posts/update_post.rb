module Mutations
  module Posts
    class UpdatePost < AuthorizedMutation
      argument :attributes, Types::PostAttributes, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(id:, attributes:)
        post = Post.find_by(id: id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?
        raise GraphQL::ExecutionError, "You cannot edit this post" unless post.user_id == current_user.id

        if post.update(attributes)
          {post: post}
        else
          {errors: post.errors.full_messages}
        end
      end
    end
  end
end
