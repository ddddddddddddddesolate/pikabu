# frozen_string_literal: true

module Types
  class PaginationType < BaseInputObject
    argument :page, Integer, required: false
    argument :per, Integer, required: false
  end
end
