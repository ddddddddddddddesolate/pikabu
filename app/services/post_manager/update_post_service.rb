# frozen_string_literal: true

module PostManager
  class UpdatePostService < ApplicationService
    attr_reader :post, :params

    def initialize(post, params)
      @post = post
      @params = params
    end

    def call
      OpenStruct.new(success: post.update(params), errors: post.errors.full_messages, post: post)
    end
  end
end
