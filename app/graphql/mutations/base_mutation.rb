module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    null false

    def cookies
      context[:cookies]
    end
  end
end
