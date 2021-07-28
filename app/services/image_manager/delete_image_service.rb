# frozen_string_literal: true

module ImageManager
  class DeleteImageService < AuthorizedService
    attr_reader :model, :image_id

    def initialize(current_user, model, image_id)
      super(current_user)

      @model = model
      @image_id = image_id
    end

    def call
      raise Exceptions::NotFoundError, "#{model.class.name} not found", model unless model.user_id == current_user.id
      raise Exceptions::NotFoundError, "#{model.class.name} doesn't contain this image" unless model.images.exists?(image_id)

      image = Image.find(image_id)
      image.destroy!

      model
    rescue ActiveRecord::RecordNotDestroyed => e
      raise Exceptions::NotDestroyedError, e.message
    end
  end
end
