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
  
    def login_user
      @authenticated_user = User.find_by_email!(params[:email])
      @authenticated_user.authenticate(params[:password]) || (raise Authentication::InvalidPassword)
      @authenticated_user.regenerate_auth_token
      generate_jwt
    end
  
    def logout_user
      @authenticated_user.update_columns(auth_token: nil)
    end

private

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      if token.size == 24
        @authenticated_user = User.find_by(auth_token: token)
        check_token_expiration if @authenticated_user
      else
        begin
          decoded_token = JWT.decode token, Rails.application.credentials.jwt_authentication, true, { algorithm: 'HS256' }
        rescue JWT::VerificationError, JWT::DecodeError
          raise Authentication::InvalidToken
        end
        @authenticated_user = User.find(decoded_token[0]["user_id"])
      end
      return @authenticated_user.present?
    end
  end

  def check_token_expiration
    seconds_since_last_call = Time.now - @authenticated_user.updated_at 
    seconds_since_last_call > 20 ? expire_token : @authenticated_user.touch
  end

  def expire_token
    @authenticated_user.update_columns(auth_token: nil)
    @authenticated_user = nil
  end

  def generate_jwt
    payload ={
      user_id: @authenticated_user.id
    }
    @jwt_token = JWT.encode payload, Rails.application.credentials.jwt_authentication, 'HS256'
  end

  def validate_jwt
    
  end
end
  