class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_back fallback_location:  root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname)
  end
end
