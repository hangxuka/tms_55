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
end
