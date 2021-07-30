# frozen_string_literal: true

module PostManager
  class CreatePostService < ApplicationService
    attr_reader :current_user, :params, :image_urls, :tag_names

    def initialize(current_user, params, image_urls, tag_names)
      @current_user = current_user
      @params = params
      @image_urls = image_urls
      @tag_names = tag_names
    end

    def call
      post = current_user.posts.new(params)

      image_urls&.map { |url| post.images << Image.new(remote_image_url: url) }
      tag_names&.map { |name| post.tags << Tag.find_or_initialize_by(name: name) }

      OpenStruct.new(success: post.save, errors: post.errors.full_messages, post: post)
    end
  end
end
