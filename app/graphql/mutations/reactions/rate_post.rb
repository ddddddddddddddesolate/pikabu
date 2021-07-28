# frozen_string_literal: true

module Mutations
  module Reactions
    class RatePost < AuthorizedMutation
      argument :id, ID, required: true
      argument :reaction, Types::Reactions, required: true

      field :post, Types::PostType, null: true

      def resolve(id:, reaction:)
        post = ReactionManager::AddReactionService.call(
          current_user, Post.includes(:user, :tags, :images, reactions: [:user]), id, reaction
        )

        { post: post }
      end
    end
  end
end
