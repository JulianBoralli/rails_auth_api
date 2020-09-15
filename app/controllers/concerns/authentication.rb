module Authentication
  include ActionController::HttpAuthentication::Token::ControllerMethods

  class InvalidToken < StandardError
    def message
      "User not authenticated. Please use a valid token!"
    end
  end

  class InvalidPassword < StandardError
    def message
      "User not authenticated. Please use a valid password!"
    end
  end

  def authenticated?
    authenticate_token || (raise Authentication::InvalidToken)
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      @authenticated_user = User.find_by(auth_token: token)
      # ActiveSupport::SecurityUtils.secure_compare(token, @user.auth_token)
      return @authenticated_user.present?
    end
  end

  def login_user
    @authenticated_user = User.find_by_email!(params[:email])
    @authenticated_user.authenticate(params[:password]) || (raise Authentication::InvalidPassword)
    @authenticated_user.regenerate_auth_token
  end

  def logout_user
    @authenticated_user.update_columns(auth_token: nil)
  end
end
  