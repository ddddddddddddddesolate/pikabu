# frozen_string_literal: true

module Mutations
  module Reactions
    class RateCommentMutation < AuthorizedMutation
      argument :comment_id, ID, required: true
      argument :reaction, Types::ReactionsType, required: true

      field :success, Boolean, null: false

      def resolve(comment_id:, reaction:)
        comment = Comment.find_by(id: comment_id)

        raise Exceptions::NotFoundError, "Comment not found" unless comment

        result = ReactionManager::AddReactionService.call(current_user, comment, reaction)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
