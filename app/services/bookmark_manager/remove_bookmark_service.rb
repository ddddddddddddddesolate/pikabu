# frozen_string_literal: true

module BookmarkManager
  class RemoveBookmarkService < ApplicationService
    attr_reader :bookmark

    def initialize(bookmark)
      @bookmark = bookmark
    end

    def call
      bookmark.destroy

      OpenStruct.new(success: bookmark.destroyed?, errors: bookmark.errors.full_messages)
    end
  end
end
