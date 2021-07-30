# frozen_string_literal: true

module Mutations
  module Images
    class AddImagesToPostMutation < AuthorizedMutation
      argument :post_id, ID, required: true
      argument :image_urls, [String], required: true

      field :post, Types::PostType, null: false

      def resolve(post_id:, image_urls:)
        post = current_user.posts.find_by(id: post_id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        result = ImageManager::AddImagesToRecordService.call(post, image_urls)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { post: post }
      end
    end
  end
end
