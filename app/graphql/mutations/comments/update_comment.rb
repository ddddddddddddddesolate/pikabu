# frozen_string_literal: true

module Mutations
  module Comments
    class UpdateComment < AuthorizedMutation
      argument :id, ID, required: true
      argument :text, String, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, text:)
        { comment: CommentManager::UpdateCommentService.call(current_user, id, text) }
      end
    end
  end
end
