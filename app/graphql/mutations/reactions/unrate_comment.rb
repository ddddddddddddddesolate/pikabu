# frozen_string_literal: true

module Mutations
  module Reactions
    class UnrateComment < AuthorizedMutation
      argument :id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:)
        { comment: ReactionManager::RemoveReactionService.call(current_user, Comment, id) }
      end
    end
  end
end
