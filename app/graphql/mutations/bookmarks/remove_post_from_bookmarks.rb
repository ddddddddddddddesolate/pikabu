module Mutations
  module Bookmarks
    class RemovePostFromBookmarks < BaseMutation
      argument :post_id, ID, required: true

      field :message, String, null: false

      def resolve(post_id:)
        post = Post.find(post_id)

        current_user.bookmarks.find_by!(bookmarkable: post).destroy

        {message: "success"}
      end
    end
  end
end
