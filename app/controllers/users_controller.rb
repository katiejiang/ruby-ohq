# Users controllers
class UsersController < ApplicationController
  before_action :set_user, except: %i[index new create]
  before_action :authenticate_user, except: %i[new create]
  before_action :permission_required, only: %i[edit update destroy]

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    reset_session
    redirect_to root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def permission_required
    redirect_to current_user if @user != current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
