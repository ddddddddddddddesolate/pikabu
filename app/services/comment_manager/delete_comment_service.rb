module CommentManager
	class DeleteCommentService < AuthorizedService
		attr_reader :id

		def initialize(current_user, id)
			super(current_user)

			@id = id
		end

		def call
			comment = current_user.comments.find(id)
			comment.destroy!

			comment.destroyed?
		rescue ActiveRecord::RecordNotFound
			raise Exceptions::NotFoundError, "Comment not found"
		rescue ActiveRecord::RecordNotDestroyed => e
			raise Exceptions::NotDestroyedError, e.message
		end
	end
end