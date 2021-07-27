module Mutations
  module Bookmarks
    class AddPostToBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :post, Types::PostType, null: false

      def resolve(id:)
        { post: BookmarkManager::CreateBookmarkService.call(current_user, Post, id) }
      end
    end
  end
end
