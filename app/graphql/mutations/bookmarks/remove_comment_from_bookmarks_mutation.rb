# frozen_string_literal: true

module Mutations
  module Bookmarks
    class RemoveCommentFromBookmarksMutation < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        success = BookmarkManager::RemoveBookmarkService.call(current_user, Comment, id)

        { success: success }
      end
    end
  end
end