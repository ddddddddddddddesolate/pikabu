module Mutations
  module Votes
    class LikePost < BaseMutation
      argument :post_id, ID, required: true

      field :post, Types::PostType, null: true

      def resolve(post_id:)
        post = Post.find(post_id)

        vote = current_user.votes.find_by(votable: post)

        if vote.present?
          vote.update(reaction: Vote::LIKE)
        else
          current_user.votes.create(votable: post, reaction: Vote::LIKE)
        end

        {post: post}
      end
    end
  end
end
