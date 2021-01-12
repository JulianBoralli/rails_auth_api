module Authorization
  include ActionController::HttpAuthentication::Token::ControllerMethods

  class AccessDenied < StandardError
    def message
      "User does not have access to this content."
    end
  end

  def authorized?
    @user = User.find(params[:id])
    @user == @authenticated_user || (raise Authorization::AccessDenied)
  end

end
  