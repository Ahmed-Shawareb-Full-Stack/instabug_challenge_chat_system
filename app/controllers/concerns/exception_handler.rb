module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # Define custom handlers for different exceptions

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActionController::ParameterMissing, with: :bad_request

    # Optionally handle more exceptions
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from StandardError, with: :internal_server_error
  end

  private

  def record_not_found(e)
    json_response({ message: e.message }, :not_found)
  end

  def unprocessable_entity(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  def bad_request(e)
    json_response({ message: e.message }, :bad_request)
  end

  def not_found(e)
    json_response({ message: e.message }, :not_found)
  end

  def internal_server_error(e)
    json_response({ message: "Internal server error: #{e.message}" }, :internal_server_error)
  end
end
