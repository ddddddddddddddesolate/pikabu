module Types
  class UserRegisterCredentials < BaseInputObject
    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true
  end
end
