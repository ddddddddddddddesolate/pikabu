# frozen_string_literal: true

module ReactionManager
  class RemoveReactionService < AuthorizedService
    attr_reader :model, :id

    def initialize(current_user, model, id)
      super(current_user)

      @model = model
      @id = id
    end

    def call
      raise Exceptions::NotFoundError, 'Model not specified' unless model

      object = model.find(id)
      reaction = current_user.reactions.find_by(reactionable: object)

      raise Exceptions::NotFoundError, "You didn't rate this #{model}" unless reaction

      reaction.destroy!

      object
    rescue ActiveRecord::RecordNotFound, e
      raise Exceptions::NotFoundError, e.message
    rescue ActiveRecord::RecordNotDestroyed => e
      raise Exceptions::NotDestroyedError, e.message
    end
  end
end
