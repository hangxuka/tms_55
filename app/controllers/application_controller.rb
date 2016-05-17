class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user  
    unless logged_in?
      flash[:error] = t "activerecord.controllers.application.danger"
      redirect_to login_url 
    end
  end
 
  def load_user
    @user = User.find params[:id]
  end

  def authorize_supervisor
    unless current_user.supervisor? || current_user.admin?
      flash[:danger] = t "flash.only_supervisor"
      redirect_to root_url
    end
  end

  def verify_supervisor
    redirect_to root_url unless current_user.supervisor?
  end
end
