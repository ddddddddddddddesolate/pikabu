# frozen_string_literal: true

module Mutations
  module Images
    class AddImageToPost < AuthorizedMutation
      argument :id, ID, required: true
      argument :url, String, required: true

      field :post, Types::PostType, null: false

      def resolve(id:, url:)
        post = Post.find(id)
        post = ImageManager::AddImageService.call(current_user, post, url)

        { post: post }
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::NotFoundError, 'Post not found'
      end
    end
  end
end
