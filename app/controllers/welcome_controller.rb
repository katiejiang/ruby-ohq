class WelcomeController < ApplicationController
  def index
    unless logged_in?
      redirect_to '/login'
      nil
    end
  end
end
