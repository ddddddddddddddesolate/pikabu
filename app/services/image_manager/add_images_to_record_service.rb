# frozen_string_literal: true

module ImageManager
  class AddImagesToRecordService < ApplicationService
    attr_reader :record, :image_urls

    def initialize(record, image_urls)
      @record = record
      @image_urls = image_urls
    end

    def call
      image_urls&.map { |url| record.images << Image.new(remote_image_url: url) }

      OpenStruct.new(success: record.save, errors: record.errors.full_messages)
    end
  end
end
