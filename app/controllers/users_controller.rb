class UsersController < ApplicationController
  before_action :jam_violation?, only: [:create]

  def create
    @user = User.create!(users_params)
    render @user, status: :created
  end

  def show
    
  end

  private

	def users_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
  
end