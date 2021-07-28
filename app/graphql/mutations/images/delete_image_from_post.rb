# frozen_string_literal: true

module Mutations
  module Images
    class DeleteImageFromPost < AuthorizedMutation
      argument :id, ID, required: true
      argument :image_id, ID, required: true

      field :post, Types::PostType, null: false

      def resolve(id:, image_id:)
        post = ImageManager::DeleteImageService.call(
          current_user, Post.includes(:user, :tags, :images, reactions: [:user]), id, image_id
        )

        { post: post }
      end
    end
  end
end
