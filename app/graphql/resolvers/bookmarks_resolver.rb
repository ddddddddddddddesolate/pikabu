module Resolvers
  class BookmarksResolver < BaseResolver
    type Types::BookmarkableType, null: false

    def resolve
      Bookmark.where(user_id: current_user.id)
    end
  end
end