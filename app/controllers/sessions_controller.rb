class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
   if @user = login(params[:email], params[:password])
     redirect_back_or_to(:instructors, notice: 'Login successful')
   else
    flash.now[:alert] = 'Login failed'
    render action: 'new'
   end
  end

  def destroy
    reset_session
    redirect_back_or_to(:instructors, notice: 'Logged out!')
  end

end
