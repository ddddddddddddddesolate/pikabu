module Types
  class PostAttributes < BaseInputObject
    argument :title, String, required: true
    argument :text, String, required: false
  end
end
