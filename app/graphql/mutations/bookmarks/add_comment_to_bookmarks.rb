module Mutations
  module Bookmarks
    class AddCommentToBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(id:)
        { comment: BookmarkManager::CreateBookmarkService.call(current_user, Comment, id) }
      end
    end
  end
end
