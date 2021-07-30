# frozen_string_literal: true

module Types
  class SortOrdersType < BaseEnum
    value 'ASC', value: :asc
    value 'DESC', value: :desc
  end
end
