# frozen_string_literal: true

module Mutations
  module Images
    class AddImageToPost < AuthorizedMutation
      argument :id, ID, required: true
      argument :url, String, required: true

      field :post, Types::PostType, null: false

      def resolve(id:, url:)
        { post: ImageManager::AddImageService.call(current_user, Post, id, url) }
      end
    end
  end
end
