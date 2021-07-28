# frozen_string_literal: true

module Mutations
  module Images
    class AddImageToComment < AuthorizedMutation
      argument :id, ID, required: true
      argument :url, String, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, url:)
        comment = Comment.find(id)
        comment = ImageManager::AddImageService.call(current_user, comment, url)

        { comment: comment }
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::NotFoundError, 'Comment not found'
      end
    end
  end
end
