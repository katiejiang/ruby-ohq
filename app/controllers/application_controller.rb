# Controller for basic application
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user
  before_action :search_contents

  private

  def search_contents
    courses = search_courses
    names = search_names
    emails = search_emails
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

  def search_courses
    Course.all.map do |course|
      {
        'category' => 'Course',
        'link' => "/courses/#{course.id}",
        'title' => course.name
      }
    end
  end

  def search_names
    User.all.map do |user|
      {
        'category' => 'User name',
        'link' => "/users/#{user.id}",
        'title' => user.name
      }
    end
  end

  def search_emails
    User.all.map do |user|
      {
        'category' => 'User email',
        'link' => "/users/#{user.id}",
        'title' => user.email
      }
    end
  end
end
