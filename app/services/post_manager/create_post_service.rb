# frozen_string_literal: true

module PostManager
  class CreatePostService < AuthorizedService
    attr_reader :attributes, :image_urls, :tag_names

    def initialize(current_user, attributes, image_urls, tag_names)
      super(current_user)

      @attributes = attributes
      @image_urls = image_urls
      @tag_names = tag_names
    end

    def call
      Post.transaction do
        post = current_user.posts.includes(:user, :tags, :images, reactions: [:user]).new(attributes.to_h)

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

        post
      rescue ActiveRecord::RecordInvalid => e
        raise Exceptions::ValidationError, e.message
      end
    end
  end
end
