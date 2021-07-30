# frozen_string_literal: true

module Mutations
  module Reactions
    class UnratePostMutation < AuthorizedMutation
      argument :post_id, ID, required: true

      field :success, Boolean, null: false

      def resolve(post_id:)
        post = Post.find_by(id: post_id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        reaction = current_user.reactions.find_by(reactionable: post)

        raise Exceptions::NotFoundError, "Reaction not found" unless reaction

        result = ReactionManager::RemoveReactionService.call(reaction)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
