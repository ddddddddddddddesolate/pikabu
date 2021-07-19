module Types
  class BookmarkType < BaseObject
    field :user, UserType, null: false
    field :bookmarkable, BookmarkableType, null: false
  end
end