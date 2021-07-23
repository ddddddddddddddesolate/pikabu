module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    null false

    def current_user
      context[:current_user]
    end

    def cookies
      context[:cookies]
    end
  end
end
