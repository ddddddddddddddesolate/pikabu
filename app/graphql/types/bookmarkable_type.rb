module Types
  class BookmarkableType < BaseUnion
    possible_types PostType, CommentType

    def self.resolve_type(object, _context)
      if object.is_a?(Post)
        PostType
      elsif object.is_a?(Comment)
        CommentType
      end
    end
  end
end