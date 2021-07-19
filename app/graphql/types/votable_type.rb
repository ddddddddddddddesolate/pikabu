module Types
  class VotableType < BaseUnion
    possible_types PostType, CommentType

    def self.resolve_type(object, context)
      if object.is_a?(Post)
        PostType
      elsif object.is_a?(Comment)
        CommentType
      end
    end
  end
end