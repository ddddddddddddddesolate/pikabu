module Types
  class PostAttributes < Types::BaseInputObject
    argument :title, String, required: true
    argument :text, String, required: false
  end
end
