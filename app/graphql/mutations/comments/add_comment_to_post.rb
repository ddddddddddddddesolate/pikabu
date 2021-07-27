module Mutations
  module Comments
    class AddCommentToPost < AuthorizedMutation
      argument :id, ID, required: true
      argument :text, String, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, text:)
        { comment: CommentManager::AddCommentService.call(current_user, Post, id, text) }
      end
    end
  end
end
