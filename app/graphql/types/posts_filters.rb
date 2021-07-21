module Types
  class PostsFilters < BaseInputObject
    argument :fresh, Boolean, required: false
    argument :hot, Boolean, required: false
    argument :best, Boolean, required: false
    argument :tags, [Integer], required: false
  end
end