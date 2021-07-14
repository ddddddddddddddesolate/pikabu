module Types
  module Auth
    class AuthProviderCredentialsInput < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end
