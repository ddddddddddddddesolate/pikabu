# frozen_string_literal: true

module BookmarkManager
  class RemoveBookmarkService < AuthorizedService
    attr_reader :model, :id

    def initialize(current_user, model, id)
      super(current_user)

      @model = model
      @id = id
    end

    def call
      object = model.find_by(id: id)

      raise Exceptions::NotFoundError, "#{model} not found" unless object

      bookmark = current_user.bookmarks.find_by(bookmarkable: object)

      raise Exceptions::NotFoundError, "#{model} not in bookmarks" unless bookmark

      bookmark.destroy!

      bookmark.destroyed?
    rescue ActiveRecord::RecordNotDestroyed => e
      raise Exceptions::NotDestroyedError, e.message
    end
  end
end
