# frozen_string_literal: true

module Exceptions
  class ValidationError < StandardError; end

  class NotFoundError < StandardError; end

  class UnauthorizedError < StandardError; end
end
