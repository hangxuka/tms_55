class Supervisor::SubjectsController < ApplicationController
  before_action :find_subject, except: [:index, :new, :create]

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def show
    @tasks = @subject.tasks
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "aplication.flash.update_subject"
      redirect_to [:supervisor, @subject]
    else
      render :edit
    end
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
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

  def destroy
    if @subject.destroy
      flash[:success] = t "flash.delete_subject"
      redirect_to supervisor_subjects_path
    else
      flash[:error] = t "flash.cannot_delete_subject"
    end
  end

  private
  def find_subject
    @subject = Subject.find params[:id]
  end

  def subject_params
    params.require(:subject).permit :name, :start_date, :end_date,
      tasks_attributes: [:id, :name, :content, :_destroy]
  end
end
