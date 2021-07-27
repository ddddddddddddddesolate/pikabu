# frozen_string_literal: true

module Types
  class OrderFields < BaseInputObject
    argument :date, SortOrders, required: false
    argument :likes, SortOrders, required: false
  end
end
