# frozen_string_literal: true

module Mutations
  module Images
    class DeleteImageFromComment < AuthorizedMutation
      argument :id, ID, required: true
      argument :image_id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, image_id:)
        { comment: ImageManager::DeleteImageService.call(current_user, Comment, id, image_id) }
      end
    end
  end
end
