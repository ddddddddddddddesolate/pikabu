# frozen_string_literal: true

module Mutations
  module Comments
    class DeleteCommentMutation < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        comment = current_user.comments.find_by(id: id)

        raise Exceptions::NotFoundError, "Comment not found" unless comment

        result = CommentManager::DeleteCommentService.call(comment)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
