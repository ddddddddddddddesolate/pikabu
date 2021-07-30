# frozen_string_literal: true

module CommentManager
  class ReplyToCommentService < ApplicationService
    attr_reader :current_user, :comment, :params

    def initialize(current_user, comment, params)
      @current_user = current_user
      @comment = comment
      @params = params

      initialize_params
    end

    def call
      replied = Comment.new(params)

      OpenStruct.new(success: replied.save, errors: replied.errors.full_messages, comment: replied)
    end

    private

    def initialize_params
      params[:user_id] = current_user.id
      params[:comment_id] = comment.id
    end
  end
end
