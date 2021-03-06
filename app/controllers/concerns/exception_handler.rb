module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from JamViolation::ChuckNorrisError, with: :render_chuck_norris_response
    rescue_from Authentication::InvalidToken, with: :render_unauthorized_response
    rescue_from Authentication::InvalidPassword, with: :render_unauthorized_response
    rescue_from Authorization::AccessDenied, with: :render_unauthorized_response
    # rescue_from JWT::VerificationError, with: :render_unauthorized_response
    # rescue_from JWT::DecodeError, with: :render_unauthorized_response
  end

  private 

  def render_record_invalid_response(exception)
    render json: { error: exception.record.errors }, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_chuck_norris_response(exception)
    render json: { error: exception.message }, status: :not_acceptable
  end

  def render_unauthorized_response(exception)
    render json: { error: exception.message }, status: :unauthorized
  end

end
