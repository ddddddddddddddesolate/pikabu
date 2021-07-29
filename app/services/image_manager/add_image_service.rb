# frozen_string_literal: true

module ImageManager
  class AddImageService < AuthorizedService
    attr_reader :model, :id, :url

    def initialize(current_user, model, id, url)
      super(current_user)

      @model = model
      @id = id
      @url = url
    end

    def call
      raise Exceptions::NotFoundError, 'Model not specified' unless model

      object = model.find(id)

      raise ActiveRecord::RecordNotFound, object unless object.user_id == current_user.id

      image = object.images.new(
        remote_image_url: url
      )

      raise ActiveRecord::RecordInvalid, image unless image.save

      object
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    rescue ActiveRecord::RecordNotFound => e
      raise Exceptions::NotFoundError, e.message
    end
  end
end
