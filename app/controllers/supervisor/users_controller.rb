class Supervisor::UsersController < ApplicationController
  before_action :logged_in_user, :verify_supervisor, only: [:new, :create, :index]
  before_action :find_user, except: [:index, :new, :create]

  def new
    @user = User.new
  end

  def show
    @user_subjects = @user.user_subjects
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "activerecord.controllers.supervisor.users.success"
      redirect_to new_supervisor_user_url
    else
      render :new
    end
  end

  def index
    @users = User.trainee.paginate page: params[:page]
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

  def destroy
    @user.destroy
    flash[:delete_success] = t "activerecord.controllers.users.delete_success"
    redirect_to supervisor_users_url
  end

  private
  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def verify_supervisor
    redirect_to root_url unless current_user.supervisor?
  end
end
