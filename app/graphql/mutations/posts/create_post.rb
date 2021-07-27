# frozen_string_literal: true

module Mutations
  module Posts
    class CreatePost < AuthorizedMutation
      argument :attributes, Types::PostAttributes, required: true
      argument :image_urls, [String], required: false
      argument :tag_names, [String], required: false

      field :post, Types::PostType, null: true

      def resolve(attributes:, image_urls: nil, tag_names: nil)
        Post.transaction do
          post = current_user.posts.new(attributes.to_h)

          raise ActiveRecord::RecordInvalid, post unless post.save

          if image_urls
            images = []

            image_urls.each do |url|
              images << post.images.new(remote_image_url: url)
            end

            Image.import images
          end

          tag_names&.each do |name|
            tag = Tag.find_or_create_by(
              name: name
            )

            post.tags << tag unless post.tags.include?(tag)
          end

          { post: post }
        rescue ActiveRecord::RecordInvalid => e
          raise Exceptions::ValidationError, e.message
        end
      end
    end
  end
end
