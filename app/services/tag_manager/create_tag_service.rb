# frozen_string_literal: true

module TagManager
  class CreateTagService < ApplicationService
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      tag = Tag.new(params)

      OpenStruct.new(success: tag.save, errors: tag.errors.full_messages, tag: tag)
    end
  end
end
