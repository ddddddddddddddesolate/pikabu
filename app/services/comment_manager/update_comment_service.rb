# frozen_string_literal: true

module CommentManager
  class UpdateCommentService < AuthorizedService
    attr_reader :id, :text

    def initialize(current_user, id, text)
      super(current_user)

      @id = id
      @text = text
    end

    def call
      comment = current_user.comments.includes(:user, :images, reactions: [:user]).find(id)

      raise ActiveRecord::RecordInvalid, comment unless comment.update(text: text)

      comment
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, 'Comment not found'
    end
  end
end
