module Mutations
  module Votes
    class LikeComment < BaseMutation
      argument :comment_id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(comment_id:)
        comment = Comment.find(comment_id)

        vote = current_user.votes.find_by(votable: comment)

        if vote.present?
          vote.update(reaction: Vote::LIKE)
        else
          current_user.votes.create(votable: comment, reaction: Vote::LIKE)
        end

        {comment: comment}
      end
    end
  end
end
