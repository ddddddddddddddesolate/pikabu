# frozen_string_literal: true

module BookmarkManager
  class CreateBookmarkService < ApplicationService
    attr_reader :current_user, :record

    def initialize(current_user, record)
      @current_user = current_user
      @record = record
    end

    def call
      bookmark = current_user.bookmarks.new(bookmarkable: record)

      OpenStruct.new(success: bookmark.save, errors: bookmark.errors.full_messages)
    end
  end
end
