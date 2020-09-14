module Authentication
  include ActionController::HttpAuthentication::Token::ControllerMethods

  class AuthorizationError < StandardError
    def message
      "User not authorized. Please use a valid token!"
    end
  end

  class InvalidPassword < StandardError
    def message
      "Login error. Please use a valid password!"
    end
  end

  def authorized?
    authenticate_token || (raise Authentication::AuthorizationError)
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      @user = User.find_by(auth_token: token)
      # ActiveSupport::SecurityUtils.secure_compare(token, @user.auth_token)
      return @user.present?
    end
  end

  def login_user
    @user = User.find_by_email!(params[:email])
    @user.authenticate(params[:password]) || (raise Authentication::InvalidPassword)
    @user.regenerate_auth_token
  end

  def logout_user
    @user.update_columns(auth_token: nil)
  end
end
  