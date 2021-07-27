module CommentManager
	class ReplyToCommentService < AuthorizedService
		attr_reader :id, :text

		def initialize(current_user, id, text)
			super(current_user)

			@id = id
			@text = text
		end

		def call
			parent_comment = Comment.find(id)

			comment = parent_comment.comments.new(
				post_id: parent_comment.post_id,
				user_id: current_user.id,
				text: text
			)

			raise ActiveRecord::RecordInvalid, comment unless comment.save

			comment
		rescue ActiveRecord::RecordInvalid => e
			raise Exceptions::ValidationError, e.message
		rescue ActiveRecord::RecordNotFound
			raise Exceptions::NotFoundError, "Parent comment not found"
		end
	end
end