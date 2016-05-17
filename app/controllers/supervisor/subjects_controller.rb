class Supervisor::SubjectsController < ApplicationController
  def index
    @subjects = Subject.all.paginate page: params[:page]
  end

  private
  def user_params
    params.require(:subject).permit :name, :start_date, :end_date
  end
end
