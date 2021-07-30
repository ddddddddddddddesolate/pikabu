# frozen_string_literal: true

module TagManager
  class DeleteTagService < ApplicationService
    attr_reader :tag

    def initialize(tag)
      @tag = tag
    end

    def call
      tag.destroy

      OpenStruct.new(success: tag.destroyed?, errors: tag.errors)
    end
  end
end
