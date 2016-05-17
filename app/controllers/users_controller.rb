class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :load_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:update_success] = t "activerecord.controllers.users.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "activerecord.controllers.users.danger"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless @user.correct_user? current_user
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
