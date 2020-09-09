class ApplicationController < ActionController::API

  # Error Handling
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_record_invalid_response(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  # Authentication

  

end
