module Mutations
  module Votes
    class UnlikeComment < BaseMutation
      argument :comment_id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(comment_id:)
        comment = Comment.find(comment_id)

        vote = current_user.votes.find_by(votable: comment)

        if vote.present?
          vote.destroy
        end

        {comment: comment}
      end
    end
  end
end
