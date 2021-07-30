# frozen_string_literal: true

module Mutations
  module Images
    class DeleteImageFromCommentMutation < AuthorizedMutation
      argument :id, ID, required: true
      argument :image_id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, image_id:)
        comment = ImageManager::DeleteImageService.call(
          current_user, Comment.includes(:user, :images, reactions: [:user]), id, image_id
        )

        { comment: comment }
      end
    end
  end
end
