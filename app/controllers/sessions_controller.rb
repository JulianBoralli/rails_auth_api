class SessionsController < ApplicationController
  before_action :authenticated?, only: [:destroy]

  def create
    login_user
    render json: { 
        id: @authenticated_user.id, 
        token: @authenticated_user.auth_token,
        jwt_token: @jwt_token
      }, 
      status: :created
  end

  def destroy
    logout_user
    render json: { message: "Succefully logged out!"}, status: :ok
  end
end