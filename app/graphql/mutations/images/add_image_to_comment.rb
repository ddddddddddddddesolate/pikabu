module Mutations
  module Images
    class AddImageToComment < AuthorizedMutation
      argument :id, ID, required: true
      argument :url, String, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:, url:)
        { comment: ImageManager::AddImageService.call(current_user, Comment, id, url) }
      end
    end
  end
end
