class WelcomeController < ApplicationController

  def index
    unless logged_in?
      redirect_to '/login'
      return
    end
  end

end
