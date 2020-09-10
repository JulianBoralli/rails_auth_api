module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from JamViolation::ChuckNorrisError, with: :render_chuck_norris_response
  end

  private 

  def render_record_invalid_response(exception)
    render json: { error: exception.record.errors }, status: :unprocessable_entity
    p exception.record.errors 
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_chuck_norris_response(exception)
    render json: { error: exception.message }, status: :not_acceptable
  end

  # class ChuckNorrisError < StandardError
  #   def message
  #     "Never use Chuck Norris name in vain!  ᕙ(▀̿̿Ĺ̯̿̿▀̿ ̿) ᕗ  "
  #   end
  # end

end
