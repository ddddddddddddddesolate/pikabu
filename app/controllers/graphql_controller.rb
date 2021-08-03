# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      cookies: cookies,
      current_user: current_user
    }
    result = PikabuSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue Exceptions::ValidationError, Exceptions::NotDestroyedError, Exceptions::InvalidCredentialsError => e
    render json: { errors: [{ message: e.message }] }, status: :unprocessable_entity
  rescue Exceptions::NotFoundError => e
    render json: { errors: [{ message: e.message }] }, status: :not_found
  rescue Exceptions::UnauthorizedError => e
    render json: { errors: [{ message: e.message }] }, status: :unauthorized
  rescue Exceptions::AlreadyExistsError => e
    render json: { errors: [{ message: e.message }] }, status: :conflict
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  def current_user
    return if cookies[:token].blank?

    token = cookies[:token]
    decoded_token = JsonWebToken.decode(token)
    user_id = decoded_token[:user_id]

    User.find(user_id)
  end

  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    render json: { errors: [{ message: error.message, backtrace: error.backtrace }], data: {} },
           status: :internal_server_error
  end
end
