# frozen_string_literal: true

class GraphqlController < ApplicationController
  include Exceptions

  def execute
    query = params[:query]
    variables = prepare_variables(params[:variables])
    context = prepare_context
    operation_name = params[:operationName]

    result = PikabuSchema.execute(query, variables: variables, context: context, operation_name: operation_name)

    render json: result
  rescue ValidationError => e
    render_error(e, :unprocessable_entity)
  rescue NotFoundError => e
    render_error(e, :not_found)
  rescue UnauthorizedError => e
    render_error(e, :unauthorized)
  rescue StandardError => e
    render_error(e, :internal_server_error)
  end

  private

  def current_user
    return if cookies[:token].blank?

    token = cookies[:token]
    decoded_token = JsonWebToken.decode(token)
    user_id = decoded_token[:user_id]

    User.find(user_id)
  end

  def prepare_context
    { cookies: cookies, current_user: current_user }
  end

  def prepare_variables(variables)
    case variables
    when String
      if variables.present?
        JSON.parse(variables) || {}
      else
        {}
      end
    when Hash
      variables
    when ActionController::Parameters
      variables.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables}"
    end
  end

  def render_error(error, status)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: { errors: [{ message: error.message }], data: {} },
           status: status
  end
end
