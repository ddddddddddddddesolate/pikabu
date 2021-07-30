# frozen_string_literal: true

module Mutations
  module Images
    class AddImagesToCommentMutation < AuthorizedMutation
      argument :comment_id, ID, required: true
      argument :image_urls, [String], required: true

      field :comment, Types::CommentType, null: false

      def resolve(comment_id:, image_urls:)
        comment = current_user.comments.find_by(id: comment_id)

        raise Exceptions::NotFoundError, "Comment not found" unless comment

        result = ImageManager::AddImagesToRecordService.call(comment, image_urls)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { comment: comment }
      end
    end
  end
end
