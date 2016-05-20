class Supervisor::SubjectsController < ApplicationController
  before_action :find_subject, only: [:show, :view_task]

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def show
    @tasks = Task.where(subject_id: params[:id])
  end

  def new
    @task = Task.new
    @subject=Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "activerecord.controllers.supervisor.subjects.create_subject"
      redirect_to supervisor_subject_path @subject
    else
      render :new
    end
  end

  private
  def find_subject
    @subject = Subject.find params[:id]
  end

  def subject_params
    params.require(:subject).permit :name, :start_date, :end_date
  end
end
