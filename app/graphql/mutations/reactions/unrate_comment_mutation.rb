# frozen_string_literal: true

module Mutations
  module Reactions
    class UnrateCommentMutation < AuthorizedMutation
      argument :comment_id, ID, required: true

      field :success, Boolean, null: false

      def resolve(comment_id:)
        comment = Comment.find_by(id: comment_id)

        raise Exceptions::NotFoundError, "Comment not found" unless comment

        reaction = current_user.reactions.find_by(reactionable: comment)

        raise Exceptions::NotFoundError, "Reaction not found" unless reaction

        result = ReactionManager::RemoveReactionService.call(reaction)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
