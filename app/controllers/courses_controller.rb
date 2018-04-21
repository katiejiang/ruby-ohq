class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_course_id, only: [:enroll, :unenroll, :invite]
  before_action :authenticate_user

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @users = User.all
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.add_admin(current_user)
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def enroll
    return if current_user.is_student?(@course) || current_user.is_staff?(@course)
    current_user.enroll(@course)
    redirect_back fallback_location: @course
  end

  def unenroll
    current_user.unenroll(@course)
    redirect_back fallback_location: @course
  end

  def invite
    params[:invites].each do |uid|
      user = User.find(uid)
      staff = Staff.find_by(user: user, course: @course)
      Staff.create(user: user, course: @course, admin: false) unless staff
    end
    redirect_to edit_course_path(@course)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def set_course_id
      @course = Course.find(params[:course_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description)
    end
end
