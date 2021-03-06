# Course questions controller
class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_question_id, only: %i[help resolve]
  before_action :authenticate_user
  before_action :set_course

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show; end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    redirect_to cq_path unless @question.user == current_user
  end

  # POST /questions
  # POST /questions.json
  def create
    qparams = question_params.merge(user_id: current_user.id, status: 'Waiting')
    @question = @course.questions.new(qparams)
    if @question.save
      redirect_to @course
    else
      render :new
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    if @question.user == current_user && @question.update(question_params)
      redirect_to cq_path
    else
      render :edit
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy if @question.user == current_user
    redirect_to @course
  end

  # POST /questions/1/help
  def help
    return unless current_user.staff?(@course)
    @question.update(status: 'Being helped')
    redirect_to cq_path
  end

  # POST /questions/1/resolve
  def resolve
    return unless current_user.staff?(@course)
    return unless @question.user == current_user
    @question.update(status: 'Resolved')
    redirect_to @course
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  def set_question_id
    @question = Question.find(params[:question_id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def cq_path
    course_question_path(@course, @question)
  end

  def question_params
    params.require(:question).permit(:user_id, :course_id, :text, :created_at)
  end
end
