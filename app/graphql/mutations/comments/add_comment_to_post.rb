# frozen_string_literal: true

module Mutations
  module Comments
    class AddCommentToPost < AuthorizedMutation
      argument :id, ID, required: true
      argument :text, String, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, text:)
        comment = CommentManager::AddCommentToPostService.call(current_user, id, text)

        { comment: comment }
      end
    end
  end
end
