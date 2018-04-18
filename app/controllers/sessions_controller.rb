class SessionsController < ApplicationController
  def new
    redirect_to '/' if current_user
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to '/'
      return
    end
    redirect_to '/login'
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
