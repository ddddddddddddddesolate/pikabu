# frozen_string_literal: true

module Mutations
  module Posts
    class CreatePost < AuthorizedMutation
      argument :attributes, Types::PostAttributes, required: true
      argument :image_urls, [String], required: false
      argument :tag_names, [String], required: false

      field :post, Types::PostType, null: true

      def resolve(attributes:, image_urls: nil, tag_names: nil)
        post = PostManager::CreatePostService.call(current_user, attributes, image_urls, tag_names)

        { post: post }
      end
    end
  end
end
