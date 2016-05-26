class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :find_course, only: :show

  def show
    @users = @course.users
    @activities = Activity.activities_of_course(@course)
      .paginate page: params[:page], per_page: 10
  end

  private
  def find_course
    @course = Course.find params[:id]
  end
end
