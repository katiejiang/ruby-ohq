class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user
  before_action :search_contents

  private

  def search_contents
    courses = Course.all.map { |course| { 'category': 'Course', 'link': "/courses/#{course.id}", 'title': course.name } }
    names = User.all.map { |user| { 'category': 'User name', 'link': "/users/#{user.id}", 'title': user.name } }
    emails = User.all.map { |user| { 'category': 'User email', 'link': "/users/#{user.id}", 'title': user.email } }
    @search_contents = (courses + names + emails).to_json.to_s.html_safe
  end

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
