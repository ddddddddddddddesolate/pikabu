# frozen_string_literal: true

module PostsTagsManager
  class AddTagsToPostService < AuthorizedService
    attr_reader :id, :tag_names

    def initialize(current_user, id, tag_names)
      super(current_user)

      @id = id
      @tag_names = tag_names
    end

    def call
      post = current_user.posts.find(id)

      tag_names.each do |name|
        tag = post.tags.find_or_create_by(name: name)

        raise ActiveRecord::RecordInvalid, tag unless tag.errors.empty?
      end

      post
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, 'Post not found'
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    end
  end
end
