module Mutations
  module Posts
    class CreatePost < Mutations::BaseMutation
      argument :title, String, required: true
      argument :text, String, required: false

      type Types::PostType

      def resolve(title: nil, text: nil)
        Post.create!(
          title: title,
          text: text,
          user: context[:current_user]
        )
      end
    end
  end
end
