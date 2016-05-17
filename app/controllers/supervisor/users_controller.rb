class Supervisor::UsersController < ApplicationController
  before_action :logged_in_user, :verify_supervisor, only: [:new, :create, :index]

  def new
    @user = User.new
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
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation	
  end

  def verify_supervisor
    redirect_to root_url unless current_user.supervisor?
  end
end
