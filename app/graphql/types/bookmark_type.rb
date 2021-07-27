# frozen_string_literal: true

module Types
  class BookmarkType < BaseObject
    field :bookmarkable, BookmarkableType, null: false
  end
end
