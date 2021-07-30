# frozen_string_literal: true

module Mutations
  module Reactions
    class RatePostMutation < AuthorizedMutation
      argument :post_id, ID, required: true
      argument :reaction, Types::ReactionsType, required: true

      field :success, Boolean, null: true

      def resolve(post_id:, reaction:)
        post = Post.find_by(id: post_id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        result = ReactionManager::AddReactionService.call(current_user, post, reaction)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
