class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

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
  rescue Exceptions::ValidationError, Exceptions::NotDestroyedError => e
    render json: { errors: [{ message: e.message }] }, status: :unprocessable_entity
  rescue Exceptions::NotFoundError => e
    render json: { errors: [{ message: e.message }] }, status: :not_found
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  def current_user
    return unless cookies[:token].present?

    token = cookies[:token]
    decoded_token = JsonWebToken.decode(token)
    user_id = decoded_token[:user_id]

    User.find(user_id)
  end

  # Handle variables in form data, JSON body, or a blank value
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
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: {errors: [{message: e.message, backtrace: e.backtrace}], data: {}}, status: 500
  end
end
