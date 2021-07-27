# frozen_string_literal: true

module Exceptions
  class ValidationError < StandardError; end

  class NotFoundError < StandardError; end

  class NotDestroyedError < StandardError; end

  class InvalidCredentialsError < StandardError; end

  class UnauthorizedError < StandardError; end

  class AlreadyExistsError < StandardError; end
end
