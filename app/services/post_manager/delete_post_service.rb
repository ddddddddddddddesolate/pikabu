# frozen_string_literal: true

module PostManager
  class DeletePostService < AuthorizedService
    attr_reader :id

    def initialize(current_user, id)
      super(current_user)

      @id = id
    end

    def call
      post = current_user.posts.find(id)

      post.destroy

      post.destroyed?
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, 'Post not found'
    rescue ActiveRecord::RecordNotDestroyed => e
      raise Exceptions::NotDestroyedError, e.message
    end
  end
end
