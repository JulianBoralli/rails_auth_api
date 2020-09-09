class UsersController < ApplicationController

  def create
    @user = User.new(users_params)
    @user.save!
  end

  def show
    
  end

  private

	def users_params
    params.permit(:username, :email, :password, :password_confirmation)
	end
end