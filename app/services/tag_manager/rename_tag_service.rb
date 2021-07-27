# frozen_string_literal: true

module TagManager
  class RenameTagService < ApplicationService
    attr_reader :id, :name

    def initialize(id, name)
      @id = id
      @name = name
    end

    def call
      tag = Tag.find(id)

      raise ActiveRecord::RecordInvalid, tag unless tag.update(name: name)

      tag
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, 'Tag not found'
    end
  end
end
