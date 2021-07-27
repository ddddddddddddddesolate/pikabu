class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  validates :user_id, uniqueness: { scope: %w[bookmarkable_id bookmarkable_type] }
end
