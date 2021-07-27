# frozen_string_literal: true

module Types
  class PostsSearch < BaseInputObject
    argument :title, String, required: false
  end
end
