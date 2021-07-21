class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  validates :bookmarkable_id, uniqueness: {scope: [:bookmarkable_id, :bookmarkable_type],
                                           message: "object already exists in bookmarks"}
end
