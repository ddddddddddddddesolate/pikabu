# frozen_string_literal: true

module Types
  class TagAttributesType < BaseInputObject
    argument :name, String, required: true
  end
end
