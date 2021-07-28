# frozen_string_literal: true

module BookmarkManager
  class CreateBookmarkService < AuthorizedService
    attr_reader :model

    def initialize(current_user, model)
      super(current_user)

      @model = model
    end

    def call
      bookmark = current_user.bookmarks.new(bookmarkable: model)

      raise Exceptions::AlreadyExistsError, "#{model.class.name} already exists in bookmarks" unless bookmark.save

      model
    end
  end
end
