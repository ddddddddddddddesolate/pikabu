# frozen_string_literal: true

module CommentManager
  class AddCommentToPostService < ApplicationService
    attr_reader :current_user, :post, :params

    def initialize(current_user, post, params)
      @current_user = current_user
      @post = post
      @params = params

      initialize_params
    end

    def call
      comment = Comment.new(params)

      OpenStruct.new(success: comment.save, errors: comment.errors.full_messages, comment: comment)
    end

    private

    def initialize_params
      params[:user_id] = current_user.id
      params[:post_id] = post.id
    end
  end
end
