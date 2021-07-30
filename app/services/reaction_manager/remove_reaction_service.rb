# frozen_string_literal: true

module ReactionManager
  class RemoveReactionService < AuthorizedService
    attr_reader :reaction

    def initialize(reaction)
      @reaction = reaction
    end

    def call
      reaction.destroy

      OpenStruct.new(success: reaction.destroyed?, errors: reaction.errors.full_messages)
    end
  end
end
