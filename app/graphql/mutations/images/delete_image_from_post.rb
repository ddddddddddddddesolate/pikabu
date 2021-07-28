# frozen_string_literal: true

module Mutations
  module Images
    class DeleteImageFromPost < AuthorizedMutation
      argument :id, ID, required: true
      argument :image_id, ID, required: true

      field :post, Types::PostType, null: false

      def resolve(id:, image_id:)
        post = Post.find(id)
        post = ImageManager::DeleteImageService.call(current_user, post, image_id)

        { post: post }
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::NotFoundError, 'Post not found'
      end
    end
  end
end
