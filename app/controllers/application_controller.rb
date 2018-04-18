class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def index
    if logged_in?
      redirect_to '/courses'
    else
      redirect_to '/login'
    end
  end

  private

  def logged_in?
    session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def authenticate_user
    redirect_to '/' unless logged_in?
  end
end
