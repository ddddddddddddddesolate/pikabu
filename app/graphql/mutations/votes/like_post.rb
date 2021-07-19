module Mutations
  module Votes
    class LikePost < BaseMutation
      argument :post_id, ID, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(post_id:)
        post = Post.find(post_id)

        vote = current_user.votes.find_by(votable: post)

        if vote.present?
          vote.update(reaction: 1)
        else
          current_user.votes.create(votable: post, reaction: 1)
        end

        { post: post }
      end
    end
  end
end