# frozen_string_literal: true

module Mutations
  module Posts
    class UpdatePostMutation < AuthorizedMutation
      argument :id, ID, required: true
      argument :attributes, Types::PostAttributesType, required: true

      field :post, Types::PostType, null: false

      def resolve(id:, attributes:)
        post = current_user.posts.find_by(id: id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        params = Hash attributes
        result = PostManager::UpdatePostService.call(post, params)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { post: result.post }
      end
    end
  end
end
