# frozen_string_literal: true

module CommentManager
  class DeleteCommentService < ApplicationService
    attr_reader :comment

    def initialize(comment)
      @comment = comment
    end

    def call
      comment.destroy

      OpenStruct.new(success: comment.destroyed?, errors: comment.errors.full_messages)
    end
  end
end
