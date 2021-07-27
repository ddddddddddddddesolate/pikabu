# frozen_string_literal: true

module TagManager
  class CreateTagService < ApplicationService
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def call
      tag = Tag.new(name: name)

      raise ActiveRecord::RecordInvalid, tag unless tag.save

      tag
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    end
  end
end
