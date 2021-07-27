# frozen_string_literal: true

module Types
  class BookmarkableType < BaseUnion
    possible_types PostType, CommentType

    def self.resolve_type(object, _context)
      case object
      when Post
        PostType
      when Comment
        CommentType
      end
    end
  end
end
