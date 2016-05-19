class UserCoursesController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :load_user, only: [:show]

  def show
    @courses = @user.courses
  end

  private
  def load_user
    @user = User.find params[:id]
  end
end
