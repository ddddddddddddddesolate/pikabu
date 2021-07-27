module BookmarkManager
	class CreateBookmarkService < AuthorizedService
		attr_reader :model, :id

		def initialize(current_user, model, id)
			super(current_user)

			@model = model
			@id = id
		end

		def call
			object = model.find_by(id: id)

			raise Exceptions::NotFoundError, "#{model} not found" unless object

			bookmark = current_user.bookmarks.new(bookmarkable: object)

			raise Exceptions::AlreadyExistsError, "#{model} already exists in bookmarks" unless bookmark.save

			object
		end
	end
end
