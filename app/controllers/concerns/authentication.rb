module Authentication
  include ActionController::HttpAuthentication::Token::ControllerMethods

  class AuthorizationError < StandardError
    def message
      "User not authorized. Please use a valid token!"
    end
  end

  def authorized?
    authenticate_token || (raise Authentication::AuthorizationError)
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      return User.find_by(auth_token: token).present?
    end
  end

  def login_valid?
    
  end
end
  