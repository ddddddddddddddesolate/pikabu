module Mutations
  module Posts
    class DeletePost < BaseMutation
      argument :id, ID, required: true

      field :message, String, null: false

      def resolve(id:)
        post = current_user.posts.find(id)

        post.destroy

        { message: 'success' }
      end
    end
  end
end
