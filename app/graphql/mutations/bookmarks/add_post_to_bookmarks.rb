# frozen_string_literal: true

module Mutations
  module Bookmarks
    class AddPostToBookmarks < AuthorizedMutation
      argument :id, ID, required: true

      field :post, Types::PostType, null: false

      def resolve(id:)
        post = Post.find(id)
        post = BookmarkManager::CreateBookmarkService.call(current_user, post)

        { post: post }
      rescue ActiveRecord::RecordNotFound
        raise Exceptions::NotFoundError, 'Post not found'
      end
    end
  end
end
