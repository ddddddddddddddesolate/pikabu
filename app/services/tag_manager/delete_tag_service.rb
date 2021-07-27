module TagManager
	class DeleteTagService < ApplicationService
		attr_reader :id

		def initialize(id)
			@id = id
		end

		def call
			tag = Tag.find(id)
			tag.destroy!

			tag.destroyed?
		rescue ActiveRecord::RecordNotFound
			raise Exceptions::NotFoundError, "Tag not found"
		rescue ActiveRecord::RecordNotDestroyed => e
			raise Exceptions::NotDestroyedError, e.message
		end
	end
end
