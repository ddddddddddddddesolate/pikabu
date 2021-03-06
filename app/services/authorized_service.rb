# frozen_string_literal: true

class AuthorizedService < ApplicationService
  attr_reader :current_user

  def initialize(current_user)
    raise Exceptions::UnauthorizedError unless current_user

    @current_user = current_user
  end
end
