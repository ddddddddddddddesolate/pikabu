# frozen_string_literal: true

module Types
  class CommentAttributesType < BaseInputObject
    argument :text, String, required: true
  end
end
