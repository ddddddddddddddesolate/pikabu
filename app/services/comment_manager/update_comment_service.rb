# frozen_string_literal: true

module CommentManager
  class UpdateCommentService < ApplicationService
    attr_reader :comment, :params

    def initialize(comment, params)
      @comment = comment
      @params = params
    end

    def call
      OpenStruct.new(success: comment.update(params), errors: comment.errors.full_messages, comment: comment)
    end
  end
end
