# frozen_string_literal: true

module PostManager
  class UpdatePostService < AuthorizedService
    attr_reader :id, :attributes

    def initialize(current_user, id, attributes)
      super(current_user)

      @id = id
      @attributes = attributes
    end

    def call
      post = current_user.posts.find(id)

      raise ActiveRecord::RecordInvalid, post unless post.update(attributes.to_h)

      { post: post }
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, 'Post not found'
    rescue ActiveRecord::RecordInvalid, e
      raise Exceptions::ValidationError, e.message
    end
  end
end
