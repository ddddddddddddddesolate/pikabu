# frozen_string_literal: true

module PostManager
  class UpdatePostService < AuthorizedService
    attr_reader :id, :title, :text

    def initialize(current_user, id, title, text)
      super(current_user)

      @id = id
      @title = title
      @text = text
    end

    def call
      post = current_user.posts.includes(:user, :tags, :images, reactions: [:user]).find(id)

      raise ActiveRecord::RecordInvalid, post unless post.update(
        title: title,
        text: text
      )

      post
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, 'Post not found'
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    end
  end
end
