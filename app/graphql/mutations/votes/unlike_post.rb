module Mutations
  module Votes
    class UnlikePost < BaseMutation
      argument :post_id, ID, required: true

      field :post, Types::PostType, null: true

      def resolve(post_id:)
        post = Post.find(post_id)

        vote = current_user.votes.find_by(votable: post)

        if vote.present?
          vote.destroy
        end

        {post: post}
      end
    end
  end
end
