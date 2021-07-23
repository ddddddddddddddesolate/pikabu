module Mutations
  module Votes
    class UnlikeComment < BaseMutation
      argument :comment_id, ID, required: true

      field :comment, Types::CommentType, null: false

      def resolve(comment_id:)
        comment = Comment.find_by(id: comment_id)

        raise GraphQL::ExecutionError, "Comment not found" unless comment.present?

        vote = current_user.votes.find_by(votable: comment)

        raise GraphQL::ExecutionError, "You didn't rate this comment" unless vote.present?

        vote.destroy

        {comment: comment}
      end
    end
  end
end
