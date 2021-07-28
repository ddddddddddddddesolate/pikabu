# frozen_string_literal: true

module BookmarkManager
  class CreateBookmarkService < AuthorizedService
    attr_reader :model, :id

    def initialize(current_user, model, id)
      super(current_user)

      @model = model
      @id = id
    end

    def call
      object = model.find(id)
      bookmark = current_user.bookmarks.new(bookmarkable: object)

      raise Exceptions::AlreadyExistsError, "#{object.class.name} already exists in bookmarks" unless bookmark.save

      object
    rescue ActiveRecord::RecordNotFound => e
      raise Exceptions::NotFoundError, e.message
    end
  end
end
