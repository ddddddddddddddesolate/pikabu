# frozen_string_literal: true

module PostsTagsManager
  class AddTagsToPostService < ApplicationService
    attr_reader :post, :tag_names

    def initialize(post, tag_names)
      @post = post
      @tag_names = tag_names
    end

    def call
      existed_tags = Tag.pluck(:name)
      new_tags = []

      tag_names.uniq.excluding(existed_tags)&.each { |name| new_tags << Tag.new(name: name) }

      post.tags << Tag.where(id: Tag.import(new_tags).ids)

      OpenStruct.new(success: post.save, errors: post.errors.full_messages, post: post)
    end
  end
end
