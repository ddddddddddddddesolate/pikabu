# frozen_string_literal: true

module Mutations
  module Bookmarks
    class RemovePostFromBookmarksMutation < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        success = BookmarkManager::RemoveBookmarkService.call(current_user, Post, id)

        { success: success }
      end
    end
  end
end
