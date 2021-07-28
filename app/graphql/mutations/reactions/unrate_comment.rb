# frozen_string_literal: true

module Mutations
  module Reactions
    class UnrateComment < AuthorizedMutation
      argument :id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:)
        comment = ReactionManager::RemoveReactionService.call(
          current_user, Comment.includes(:user, :images, reactions: [:user]), id
        )

        { comment: comment }
      end
    end
  end
end
