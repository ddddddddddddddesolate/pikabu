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

      vote = current_user.reactions.find_or_initialize_by(reactionable: object)

      if vote.new_record?
        vote.reaction = reaction
        vote.save
      else
        vote.update(reaction: reaction)
      end

      object
    rescue ActiveRecord::RecordInvalid
      raise Exceptions::ValidationError, "Validation failed"
    rescue ActiveRecord::RecordNotFound
      raise Exceptions::NotFoundError, "#{model} not found"
    end
  end
end
