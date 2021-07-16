module Types
  class TagAttributes < Types::BaseInputObject
    argument :name, String, required: true
  end
end
