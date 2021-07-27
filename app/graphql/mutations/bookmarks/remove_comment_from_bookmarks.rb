module Mutations
  module Bookmarks
    class RemoveCommentFromBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        { success: BookmarkManager::RemoveBookmarkService.call(current_user, Comment, id) }
      end
    end
  end
end
