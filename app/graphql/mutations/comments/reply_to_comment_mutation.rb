# frozen_string_literal: true

module Mutations
  module Comments
    class ReplyToCommentMutation < AuthorizedMutation
      argument :id, ID, required: true
      argument :text, String, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, text:)
        comment = CommentManager::ReplyToCommentService.call(current_user, id, text)

        { comment: comment }
      end
    end
  end
end