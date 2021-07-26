module Exceptions
  class ValidationError < StandardError; end
  class NotFoundError < StandardError; end
  class NotDestroyedError < StandardError; end
end
