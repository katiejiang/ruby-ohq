# Welcome controller
class WelcomeController < ApplicationController
  def index
    redirect_to '/login' unless logged_in?
  end
end
