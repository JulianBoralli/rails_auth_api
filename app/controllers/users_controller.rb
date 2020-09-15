class UsersController < ApplicationController
  before_action :jam_violation?, only: [:create]
  before_action :authenticated?, only: [:show]
  before_action :authorized?, only: [:show]

  def create
    @user = User.create!(users_params)
    render json: { token: @user.auth_token}, status: :created
  end

  def show
    render json: { username: @user.username}, status: :ok
  end

  private

	def users_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
  
end