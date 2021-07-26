module Mutations
  module Reactions
    class UnrateComment < AuthorizedMutation
      argument :id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:)
        { comment: ReactionsManager::ReactionRemover.call(current_user, Comment, id) }
      end
    end
  end
end
