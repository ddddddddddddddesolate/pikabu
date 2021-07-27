# frozen_string_literal: true

module ImageManager
  class DeleteImageService < AuthorizedService
    attr_reader :model, :id, :image_id

    def initialize(current_user, model, id, image_id)
      super(current_user)

      @model = model
      @id = id
      @image_id = image_id
    end

    def call
      object = model.find(id)

      raise ActiveRecord::RecordNotFound, object unless object.user_id == current_user.id
      raise Exceptions::NotFoundError, "#{model} doesn't contain this image" unless object.images.exists?(image_id)

      image = Image.find(image_id)
      image.destroy!

      object
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, "#{model} not found"
    rescue ActiveRecord::RecordNotDestroyed => e
      raise Exceptions::NotDestroyedError, e.message
    end
  end
end
