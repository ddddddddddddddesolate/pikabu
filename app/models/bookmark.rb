# frozen_string_literal: true

class Bookmark < ApplicationRecord
  ALLOWED_TYPES = %w[Post Comment].freeze

  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  counter_culture :user

  validates :user_id, uniqueness: { scope: %w[bookmarkable_id bookmarkable_type] }
  validates :bookmarkable_type, presence: true, inclusion: { in: ALLOWED_TYPES }
end
