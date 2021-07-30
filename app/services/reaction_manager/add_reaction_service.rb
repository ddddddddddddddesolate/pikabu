# frozen_string_literal: true

module ReactionManager
  class AddReactionService < AuthorizedService
    attr_reader :current_user, :record, :value

    def initialize(current_user, record, value)
      @current_user = current_user
      @record = record
      @value = value
    end

    def call
      reaction = current_user.reactions.find_or_initialize_by(reactionable: record)

      OpenStruct.new(success: reaction.update(reaction: value), errors: reaction.errors.full_messages)
    end
  end
end
