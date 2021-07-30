# frozen_string_literal: true

module Mutations
  module Bookmarks
    class AddPostToBookmarksMutation < AuthorizedMutation
      argument :id, ID, required: true

      field :post, Types::PostType, null: false

      def resolve(id:)
        post = BookmarkManager::CreateBookmarkService.call(
          current_user, Post.includes(:user, :tags, :images, reactions: [:user]), id
        )

        { post: post }
      end
    end
  end
end
