class SessionsController < ApplicationController
  before_action :authorized?, only: [:destroy]

  def create
    login_user
    render json: { , id: @user.id, token: @user.auth_token}, status: :created
  end

  def destroy
    logout_user
    render json: { message: "Succefully logged out!"}, status: :ok
  end
end