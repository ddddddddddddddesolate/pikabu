# frozen_string_literal: true

module CommentManager
  class AddCommentToPostService < AuthorizedService
    attr_reader :id, :text

    def initialize(current_user, id, text)
      super(current_user)

      @model = model
      @id = id
      @text = text
    end

    def call
      post = current_user.posts.find(id)

      comment = post.comments.includes(:user, :images, reactions: [:user]).new(
        user_id: current_user.id,
        text: text
      )

      raise ActiveRecord::RecordInvalid, comment unless comment.save

      comment
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, 'Post not found'
    end
  end
end
