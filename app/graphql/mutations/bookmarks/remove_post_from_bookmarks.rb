# frozen_string_literal: true

module Mutations
  module Bookmarks
    class RemovePostFromBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        post = Post.find(id)
        success = BookmarkManager::RemoveBookmarkService.call(current_user, post)

        { success: success }
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::NotFoundError, 'Post not found'
      end
    end
  end
end
