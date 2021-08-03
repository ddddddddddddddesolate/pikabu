# frozen_string_literal: true

module Types
  class BookmarkableType < BaseUnion
    possible_types PostType, CommentType

    def self.resolve_type(object, _context)
      return PostType if object.is_a?(Post)
      return CommentType if object.is_a?(Comment)
    end
  end
end
