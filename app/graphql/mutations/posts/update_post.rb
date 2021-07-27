# frozen_string_literal: true

module Mutations
  module Posts
    class UpdatePost < AuthorizedMutation
      argument :id, ID, required: true
      argument :attributes, Types::PostAttributes, required: true

      field :post, Types::PostType, null: false

      def resolve(id:, attributes:)
        post = current_user.posts.find_by(id: id)

        raise Exceptions::NotFoundError, 'Post not found' unless post
        raise Exceptions::ValidationError, post.errors.full_messages.join(', ') unless post.update(attributes.to_h)

        { post: post }
      end
    end
  end
end
