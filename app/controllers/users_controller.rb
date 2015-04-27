class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_back_or_to(products_url)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember)
  end

  def user
    @user ||= User.find_by(id: params[:id])
  end
end
