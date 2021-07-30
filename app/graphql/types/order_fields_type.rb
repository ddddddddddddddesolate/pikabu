# frozen_string_literal: true

module Types
  class OrderFieldsType < BaseInputObject
    argument :date, SortOrdersType, required: false
    argument :likes, SortOrdersType, required: false
  end
end
