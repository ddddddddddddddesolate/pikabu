# frozen_string_literal: true

module Types
  class PaginationType < BaseInputObject
    argument :limit, Integer, required: true
    argument :offset, Integer, required: true
  end
end
