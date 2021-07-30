# frozen_string_literal: true

module Types
  class PostsSearchType < BaseInputObject
    argument :title, String, required: false
  end
end
