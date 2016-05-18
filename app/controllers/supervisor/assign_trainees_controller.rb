class Supervisor::AssignTraineesController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :verify_supervisor, :load_course, only: [:edit, :update]
  before_action :load_trainees, only: [:edit]

  def edit
    @users.each do |user|
      user_course = UserCourse.find_by user: user, course: @course
      @course.user_courses.build user: user if user_course.nil?
    end
  end

  def update
    if @course.update_attributes user_course_params
      flash[:success] = t "activerecord.controllers.supervisor.assign_trainee.success"
      redirect_to supervisor_courses_url
    else
      render :edit
    end
  end

  private
  def user_course_params
    params.require(:course).permit user_courses_attributes: [:id, :user_id, :_destroy]
  end

  def load_trainees
    @users = User.trainee
  end

  def load_course
    @course = Course.find params[:course_id]
  end
end
