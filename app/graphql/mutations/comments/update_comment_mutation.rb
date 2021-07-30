# frozen_string_literal: true

module Mutations
  module Comments
    class UpdateCommentMutation < AuthorizedMutation
      argument :id, ID, required: true
      argument :attributes, Types::CommentAttributesType, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, attributes:)
        comment = current_user.comments.find_by(id: id)

        raise Exceptions::NotFoundError, "Comment not found" unless comment

        params = Hash attributes
        result = CommentManager::UpdateCommentService.call(comment, params)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { comment: result.comment }
      end
    end
  end
end
