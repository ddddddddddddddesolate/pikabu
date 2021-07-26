module Mutations
  module Reactions
    class RateComment < AuthorizedMutation
      argument :id, ID, required: true
      argument :reaction, Types::Reactions, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, reaction:)
        { comment: ReactionManager::ReactionCreator.call(current_user, Comment, id, reaction) }
      end
    end
  end
end
