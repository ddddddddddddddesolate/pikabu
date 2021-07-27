# frozen_string_literal: true

module Resolvers
  class BookmarksResolver < BaseResolver
    type [Types::BookmarkType], null: false

    argument :paginate, Types::Pagination, required: false

    def resolve(paginate: nil)
      bookmarks = current_user.bookmarks

      if paginate
        bookmarks = bookmarks.limit(paginate.limit)
        bookmarks = bookmarks.offset(paginate.offset)
      end

      bookmarks
    end
  end
end
