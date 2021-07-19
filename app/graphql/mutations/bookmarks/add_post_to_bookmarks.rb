module Mutations
  module Bookmarks
    class AddPostToBookmarks < BaseMutation
      argument :post_id, ID, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(post_id:)
        post = Post.find(post_id)

        bookmark = current_user.bookmarks.new(bookmarkable: post)

        if bookmark.save
          { post: post }
        else
          { errors: bookmark.errors.full_messages }
        end
      end
      end
    end
  end