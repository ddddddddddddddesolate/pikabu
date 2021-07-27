# frozen_string_literal: true

module PostsTagsManager
  class RemoveTagsFromPostService < AuthorizedService
    attr_reader :id, :tag_ids

    def initialize(current_user, id, tag_ids)
      super(current_user)

      @id = id
      @tag_ids = tag_ids
    end

    def call
      post = current_user.posts.find(id)

      tags = Tag.where(id: tag_ids)

      post.tags.delete(tags)

      post
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, 'Post not found'
    rescue ActiveRecord::RecordNotDestroyed => e
      raise Exceptions::NotDestroyedError, e.message
    end
  end
end
