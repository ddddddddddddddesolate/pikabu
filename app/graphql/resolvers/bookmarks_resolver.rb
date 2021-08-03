# frozen_string_literal: true

module Resolvers
  class BookmarksResolver < AuthorizedResolver
    type [Types::BookmarkType], null: false

    argument :paginate, Types::PaginationType, required: false

    def resolve(paginate: nil)
      bookmarks = current_user.bookmarks.includes(:bookmarkable).page(1)
      bookmarks = bookmarks.page(paginate.page).per(paginate.per) if paginate

      bookmarks
    end
  end
end
