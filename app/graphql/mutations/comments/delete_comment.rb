# frozen_string_literal: true

module Mutations
  module Comments
    class DeleteComment < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        success = CommentManager::DeleteCommentService.call(current_user, id)

        { success: success }
      end
    end
  end
end
