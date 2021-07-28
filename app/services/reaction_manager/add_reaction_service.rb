# frozen_string_literal: true

module ReactionManager
  class AddReactionService < AuthorizedService
    attr_reader :model, :id, :reaction

    def initialize(current_user, model, id, reaction)
      super(current_user)

      @model = model
      @id = id
      @reaction = reaction
    end

    def call
      object = model.find(id)

      reaction = current_user.reactions.find_or_initialize_by(reactionable: object)

      if reaction.new_record?
        reaction.reaction = reaction
        reaction.save
      else
        reaction.update(reaction: reaction)
      end

      object
    rescue ActiveRecord::RecordInvalid => e
      raise Exceptions::ValidationError, e.message
    rescue ActiveRecord::RecordNotFound => e
      raise Exceptions::NotFoundError, e.message
    end
  end
end
