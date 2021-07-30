# frozen_string_literal: true

module TagManager
  class UpdateTagService < ApplicationService
    attr_reader :tag, :params

    def initialize(tag, params)
      @tag = tag
      @params = params
    end

    def call
      OpenStruct.new(success: tag.update(params), errors: tag.errors.full_messages, tag: tag)
    end
  end
end
