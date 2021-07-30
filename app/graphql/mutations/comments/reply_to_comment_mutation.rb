# frozen_string_literal: true

module Mutations
  module Comments
    class ReplyToCommentMutation < AuthorizedMutation
      argument :comment_id, ID, required: true
      argument :attributes, Types::CommentAttributesType, required: true

      field :comment, Types::CommentType, null: false

      def resolve(comment_id:, attributes:)
        comment = Comment.find_by(id: comment_id)

        raise Exceptions::NotFoundError, "Comment not found" unless comment

        params = Hash attributes
        result = CommentManager::ReplyToCommentService.call(current_user, comment, params)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { comment: result.comment }
      end
    end
  end
end
