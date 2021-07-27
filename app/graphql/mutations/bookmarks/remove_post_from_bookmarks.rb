# frozen_string_literal: true

module Mutations
  module Bookmarks
    class RemovePostFromBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        { success: BookmarkManager::RemoveBookmarkService.call(current_user, Post, id) }
      end
    end
  end
end
