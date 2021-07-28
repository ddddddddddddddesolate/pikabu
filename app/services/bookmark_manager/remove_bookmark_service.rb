# frozen_string_literal: true

module BookmarkManager
  class RemoveBookmarkService < AuthorizedService
    attr_reader :model

    def initialize(current_user, model)
      super(current_user)

      @model = model
    end

    def call
      bookmark = current_user.bookmarks.find_by(bookmarkable: model)

      raise Exceptions::NotFoundError, "#{model.class.name} not in bookmarks" unless bookmark

      bookmark.destroy!

      bookmark.destroyed?
    rescue ActiveRecord::RecordNotDestroyed => e
      raise Exceptions::NotDestroyedError, e.message
    end
  end
end
