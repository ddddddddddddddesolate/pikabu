# frozen_string_literal: true

module ReactionManager
  class AddReactionService < AuthorizedService
    attr_reader :model, :id, :value

    def initialize(current_user, model, id, value)
      super(current_user)

      @model = model
      @id = id
      @value = value
    end

    def call
      raise Exceptions::NotFoundError, 'Model not specified' unless model

      object = model.find(id)
      reaction = current_user.reactions.find_or_initialize_by(reactionable: object)

      raise ActiveRecord::RecordInvalid, reaction unless reaction.update(reaction: value)

      object
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    rescue ActiveRecord::RecordNotFound => e
      raise Exceptions::NotFoundError, e.message
    end
  end
end
