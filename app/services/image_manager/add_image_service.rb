# frozen_string_literal: true

module ImageManager
  class AddImageService < AuthorizedService
    attr_reader :model, :id, :url

    def initialize(current_user, model, url)
      super(current_user)

      @model = model
      @url = url
    end

    def call
      raise ActiveRecord::RecordNotFound unless model.user_id == current_user.id

      image = model.images.new(
        remote_image_url: url
      )

      raise ActiveRecord::RecordInvalid, image unless image.save

      model
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, "#{model.class.name} not found"
    end
  end
end
