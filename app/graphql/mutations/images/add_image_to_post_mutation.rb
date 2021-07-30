# frozen_string_literal: true

module Mutations
  module Images
    class AddImageToPostMutation < AuthorizedMutation
      argument :id, ID, required: true
      argument :url, String, required: true

      field :post, Types::PostType, null: false

      def resolve(id:, url:)
        post = ImageManager::AddImageService.call(
          current_user, Post.includes(:user, :tags, :images, reactions: [:user]), id, url
        )

        { post: post }
      end
    end
  end
end
