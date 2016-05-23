class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :find_course, only: :show

  def show
    @users = @course.users
  end

  private
  def find_course
    @course = Course.find params[:id]
  end
end
