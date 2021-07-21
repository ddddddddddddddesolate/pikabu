module Mutations
  module PostsTags
    class RemoveTagFromPost < BaseMutation
      argument :post_id, ID, required: true
      argument :tag_id, ID, required: true

      field :post, Types::PostType, null: false

      def resolve(post_id:, tag_id:)
        post = current_user.posts.find(post_id)
        tag = Tag.find(tag_id)

        post.tags.delete(tag)

        {post: post}
      end
    end
  end
end
