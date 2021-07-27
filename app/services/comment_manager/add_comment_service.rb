module CommentManager
	class AddCommentService < AuthorizedService
		attr_reader :model, :id, :text

		def initialize(current_user, model, id, text)
			super(current_user)

			@model = model
			@id = id
			@text = text
		end

		def call
			object = model.find(id)

			comment = object.comments.new(
				user_id: current_user.id,
				text: text
			)

			raise ActiveRecord::RecordInvalid, comment unless comment.save

			comment
		rescue ActiveRecord::RecordInvalid => e
			raise Exceptions::ValidationError, e.message
		rescue ActiveRecord::RecordNotFound
			raise Exceptions::NotFoundError, "#{model} not found"
		end
	end
end