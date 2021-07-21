module Types
  class PostFilters < BaseInputObject
    argument :fresh, Boolean, required: false
    argument :hot, Boolean, required: false
    argument :best, Boolean, required: false
  end
end