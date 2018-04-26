# Courses controller
class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]
  before_action :set_course_id, only: %i[help enroll unenroll invite
                                         change_admin change_staff remove_staff]
  before_action :authenticate_user
  before_action :admin_only, only: %i[invite change_admin change_staff destroy]
  before_action :staff_only, only: %i[edit update]
  before_action :find_user, only: %i[change_admin change_staff remove_staff]

  def index
    @courses = Course.all
  end

  def show; end

  def new
    @course = Course.new
  end

  def edit
    @users = User.all
  end

  def create
    @course = Course.new(course_params)
    @course.add_admin(current_user)
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        notice = 'Course was successfully updated.'
        format.html { redirect_to edit_course_path(@course), notice: notice }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      notice = 'Course was successfully destroyed.'
      format.html { redirect_to courses_url, notice: notice }
      format.json { head :no_content }
    end
  end

  def help
    if current_user.is_staff?(@course)
      @course.queue.each do |question|
        cqpath = course_question_path(@course, question)
        redirect_to cqpath if question.status == 'Waiting'
      end
    end
    redirect_to @course
  end

  def enroll
    return if current_user.is_student?(@course)
    return if current_user.is_staff?(@course)
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
      if user
        staff = Staff.find_by(user: user, course: @course)
        Staff.create(user: user, course: @course, admin: false) unless staff
      end
    end
    notice = 'Successfully invited users to staff.'
    redirect_to edit_course_path(@course), notice: notice
  end

  def change_admin
    redirect_to edit_course_path(@course) unless @user
    staff = Staff.find_by(user: @user, course: @course)
    redirect_to edit_course_path(@course) unless staff
    staff.update(admin: true)
    notice = "Promoted #{@user.name} to an admin."
    redirect_to edit_course_path(@course), notice: notice
  end

  def change_staff
    redirect_to edit_course_path(@course) unless @user
    staff = Staff.find_by(user: @user, course: @course)
    redirect_to edit_course_path(@course) unless staff
    staff.update(admin: false)
    notice = "Removed admin status from #{@user.name}."
    redirect_to edit_course_path(@course), notice: notice
  end

  def remove_staff
    if params[:uid] != current_user.id
      @course.remove_staff(@user) if @user
      redirect_to edit_course_path(@course), notice:
        "Removed #{@user.name} from staff."
    else
      @course.remove_staff(current_user)
      redirect_to @course, notice:
        "Successfully left the staff for #{@course.name}."
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def find_user
    @user = User.find(params[:uid])
  end

  def set_course_id
    @course = Course.find(params[:course_id])
  end

  def admin_only
    return unless current_user.is_admin?(@course)
  end

  def staff_only
    redirect_to @course unless current_user.is_staff?(@course)
  end

  def course_params
    params.require(:course).permit(:name, :description)
  end
end
