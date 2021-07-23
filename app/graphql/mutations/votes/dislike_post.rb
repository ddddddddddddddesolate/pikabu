module Mutations
  module Votes
    class DislikePost < BaseMutation
      argument :post_id, ID, required: true

      field :post, Types::PostType, null: true

      def resolve(post_id:)
        post = Post.find_by(id: post_id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?

        vote = current_user.votes.find_by(votable: post)

        if vote.present?
          vote.update(reaction: Vote::DISLIKE)
        else
          current_user.votes.create(votable: post, reaction: Vote::DISLIKE)
        end

        {post: post}
      end
    end
  end
end
