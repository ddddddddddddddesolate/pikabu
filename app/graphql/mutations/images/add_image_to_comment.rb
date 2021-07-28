# frozen_string_literal: true

module Mutations
  module Images
    class AddImageToComment < AuthorizedMutation
      argument :id, ID, required: true
      argument :url, String, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, url:)
        comment = ImageManager::AddImageService.call(
          current_user, Comment.includes(:user, :images, reactions: [:user]), id, url
        )

        { comment: comment }
      end
    end
  end
end
