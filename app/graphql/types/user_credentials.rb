module Types
  class UserCredentials < BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
    argument :name, String, required: false
  end
end
