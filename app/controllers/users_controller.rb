class UsersController < ApplicationController

  def create
    
  end

  def show
    
  end

  private

	def users_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end
end