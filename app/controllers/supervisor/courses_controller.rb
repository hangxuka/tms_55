class Supervisor::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :find_course, except: [:index, :new, :create, :update, :edit]
  before_action :verify_supervisor, only: [:edit, :update]
  
  def index
    @courses = Course.paginate page: params[:page]
  end
  
  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t ".courses.create_course"
      redirect_to supervisor_course_path @course
    else
      render :new
    end
  end

  private
  def find_course
    @course = Course.find params[:id]
  end

  def course_params
    params.require(:course).permit :name, :description, :start_date, :end_date, :status
  end
end
