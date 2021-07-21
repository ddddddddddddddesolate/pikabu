module Types
  class Pagination < BaseInputObject
    argument :limit, Integer, required: true
    argument :offset, Integer, required: true
  end
end