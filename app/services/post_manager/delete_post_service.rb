# frozen_string_literal: true

module PostManager
  class DeletePostService < ApplicationService
    attr_reader :post

    def initialize(post)
      @post = post
    end

    def call
      post.destroy

      OpenStruct.new(success: post.destroyed?, errors: post.errors.full_messages)
    end
  end
end
