module Mutations
  module PostsTags
    class AddTagToPost < AuthorizedMutation
      argument :post_id, ID, required: true
      argument :tag_id, ID, required: true

      field :post, Types::PostType, null: false

      def resolve(post_id:, tag_id:)
        post = Post.find_by(id: post_id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?
        raise GraphQL::ExecutionError, "You cannot tag this post" unless post.user_id == current_user.id

        tag = Tag.find_by(id: tag_id)

        raise GraphQL::ExecutionError, "Tag not found" unless tag.present?
        raise GraphQL::ExecutionError, "Tag already exists in this post" if post.tags.exists?(tag_id)

        post.tags << tag

        {post: post}
      end
    end
  end
end
