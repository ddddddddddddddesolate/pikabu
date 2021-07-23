module Mutations
  module Votes
    class UnlikePost < AuthorizedMutation
      argument :post_id, ID, required: true

      field :post, Types::PostType, null: true

      def resolve(post_id:)
        post = Post.find_by(id: post_id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?

        vote = current_user.votes.find_by(votable: post)

        raise GraphQL::ExecutionError, "You didn't rate this post" unless vote.present?

        vote.destroy

        {post: post}
      end
    end
  end
end
