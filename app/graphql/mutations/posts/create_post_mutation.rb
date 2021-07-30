# frozen_string_literal: true

module Mutations
  module Posts
    class CreatePostMutation < AuthorizedMutation
      argument :attributes, Types::PostAttributesType, required: true
      argument :image_urls, [String], required: false
      argument :tag_names, [String], required: false

      field :post, Types::PostType, null: true

      def resolve(attributes:, image_urls: nil, tag_names: nil)
        params = Hash attributes
        result = PostManager::CreatePostService.call(current_user, params, image_urls, tag_names)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { post: result.post }
      end
    end
  end
end
