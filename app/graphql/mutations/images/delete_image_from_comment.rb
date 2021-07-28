# frozen_string_literal: true

module Mutations
  module Images
    class DeleteImageFromComment < AuthorizedMutation
      argument :id, ID, required: true
      argument :image_id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, image_id:)
        comment = Comment.find(id)
        comment = ImageManager::DeleteImageService.call(current_user, comment, image_id)

        { comment: comment }
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::NotFoundError, 'Comment not found'
      end
    end
  end
end
