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
      raise Exceptions::NotFoundError, 'Model not specified' unless model

      object = model.find(id)
      bookmark = current_user.bookmarks.find_by(bookmarkable: object)

      raise Exceptions::NotFoundError, "#{model} not in bookmarks" unless bookmark

      bookmark.destroy!

      bookmark.destroyed?
    rescue ActiveRecord::RecordNotFound => e
      raise Exceptions::NotFoundError, e.message
    rescue ActiveRecord::RecordNotDestroyed => e
      raise Exceptions::NotDestroyedError, e.message
    end
  end
end
