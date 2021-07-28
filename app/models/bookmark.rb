# frozen_string_literal: true

class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  counter_culture :user

  validates :user_id, uniqueness: { scope: %w[bookmarkable_id bookmarkable_type] }
end
