class Supervisor::AssignTrainersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :verify_supervisor, :load_course, only: [:edit, :update]
  before_action :load_trainers, only: [:edit]

  def edit
    @users.each do |user|
      @course.user_courses.find_or_initialize_by user: user
    end
  end

  def update
    if @course.update_attributes user_course_params
      flash[:success] = t "activerecord.controllers.supervisor.assign_trainer.success"
      redirect_to supervisor_courses_url
    else
      render :edit
    end
  end

  private
  def user_course_params
    params.require(:course).permit user_courses_attributes: [:id, :user_id, :_destroy]
  end

  def load_trainers
    @users = User.supervisor
  end

  def load_course
    @course = Course.find params[:course_id]
  end
end
