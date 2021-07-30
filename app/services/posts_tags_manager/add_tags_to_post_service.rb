# frozen_string_literal: true

module PostsTagsManager
  class AddTagsToPostService < ApplicationService
    attr_reader :post, :tag_names

    def initialize(post, tag_names)
      @post = post
      @tag_names = tag_names
    end

    def call
      tag_names&.map do |name|
        tag = Tag.find_or_initialize_by(name: name)
        post.tags << tag unless post.tags.exists?(tag.id)
      end

      OpenStruct.new(success: post.save, errors: post.errors.full_messages, post: post)
    end
  end
end
