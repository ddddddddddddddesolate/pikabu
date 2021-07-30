# frozen_string_literal: true

module Mutations
  module PostsTags
    class AddTagsToPostMutation < AuthorizedMutation
      argument :post_id, ID, required: true
      argument :tag_names, [String], required: true

      field :post, Types::PostType, null: false

      def resolve(post_id:, tag_names:)
        post = current_user.posts.find_by(id: post_id)

        raise Exceptions::NotFoundError, "Pot not found" unless post

        result = PostsTagsManager::AddTagsToPostService.call(post, tag_names)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { post: result.post }
      end
    end
  end
end
