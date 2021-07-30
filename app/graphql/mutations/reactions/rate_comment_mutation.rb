# frozen_string_literal: true

module Mutations
  module Reactions
    class RateCommentMutation < AuthorizedMutation
      argument :id, ID, required: true
      argument :reaction, Types::ReactionsType, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, reaction:)
        comment = ReactionManager::AddReactionService.call(
          current_user, Comment.includes(:user, :images, reactions: [:user]), id, reaction
        )

        { comment: comment }
      end
    end
  end
end
