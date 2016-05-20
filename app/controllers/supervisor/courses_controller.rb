class Supervisor::CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :find_course, except: [:index, :new, :create]
  before_action :verify_supervisor

  def index
    @courses = Course.paginate page: params[:page]
  end

  def new
    @course = Course.new
  end

  def show
    @course_subjects = @course.course_subjects
  end

  def edit
  end

  def update
    begin
      if @course.update_attributes course_params
        flash[:success] = t "activerecord.controllers.supervisor
          .courses.course_update_success"
        redirect_to supervisor_course_path @course
      else
        flash[:danger] = t "activerecord.controllers.supervisor
          .courses.course_update_failed"
        render :edit
      end
    end
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "activerecord.controllers.supervisor.courses.create_course"
      redirect_to supervisor_course_path @course
    else
      render :new
    end
  end

  def destroy
    @course.destroy
    flash[:delete_success] = t "activerecord.controllers.users.delete_success"
    redirect_to supervisor_courses_url
  end

  private
  def find_course
    @course = Course.find params[:id]
  end

  def course_params
    params.require(:course).permit :name, :description, :start_date, :end_date, :status
  end
end
