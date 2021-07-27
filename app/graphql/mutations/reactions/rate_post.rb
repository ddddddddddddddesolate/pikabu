module Mutations
  module Reactions
    class RatePost < AuthorizedMutation
      argument :id, ID, required: true
      argument :reaction, Types::Reactions, required: true

      field :post, Types::PostType, null: true

      def resolve(id:, reaction:)
        { post: ReactionManager::AddReactionService.call(current_user, Post, id, reaction) }
      end
    end
  end
end
