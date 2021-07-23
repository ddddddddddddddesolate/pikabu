module Mutations
  module Bookmarks
    class AddPostToBookmarks < AuthorizedMutation
      argument :post_id, ID, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(post_id:)
        post = Post.find_by(id: post_id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?
        raise GraphQL::ExecutionError, "Post already in bookmarks" if post.bookmarks.exists?(bookmarkable: post)

        bookmark = current_user.bookmarks.new(bookmarkable: post)

        if bookmark.save
          {post: post}
        else
          {errors: bookmark.errors.full_messages}
        end
      end
    end
  end
end
