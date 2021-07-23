module Mutations
  module Bookmarks
    class RemovePostFromBookmarks < BaseMutation
      argument :post_id, ID, required: true

      field :message, String, null: false

      def resolve(post_id:)
        post = Post.find_by(id: post_id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?
        raise GraphQL::ExecutionError, "Post not in bookmarks" unless current_user.bookmarks.exists?(bookmarkable: post)

        current_user.bookmarks.find_by(bookmarkable: post).destroy

        {message: "success"}
      end
    end
  end
end
