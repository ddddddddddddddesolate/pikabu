# frozen_string_literal: true

module Types
  class PostsFiltersType < BaseInputObject
    argument :fresh, Boolean, required: false
    argument :hot, Boolean, required: false
    argument :best, Boolean, required: false
    argument :tags, [Integer], required: false
  end
end
