module Mutations
  module PostsTags
    class RemoveTagsFromPost < BaseMutation
      argument :post_id, ID, required: true
      argument :tags, [String], required: true

      field :post, Types::PostType, null: false

      def resolve(post_id:, tags:)
        authenticate_user!

        post = context[:current_user].posts.find_by(id: post_id)

        raise GraphQL::ExecutionError, 'Post not found' unless post.present?

        tags.each do |tag_name|
          post.tags.find_by(name: tag_name).destroy
        end

        { post: post }
      end
    end
  end
end
