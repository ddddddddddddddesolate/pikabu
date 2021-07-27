# frozen_string_literal: true

module Mutations
  module Reactions
    class UnratePost < AuthorizedMutation
      argument :id, ID, required: true

      field :post, Types::PostType, null: true

      def resolve(id:)
        { post: ReactionManager::RemoveReactionService.call(current_user, Post, id) }
      end
    end
  end
end
