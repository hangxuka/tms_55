class Supervisor::TasksController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :load_subject, only: [:show]

  def show
    @task = @subject.tasks
  end

  def index
  end

  def new
    @task=Task.new
  end

  def create
    @task = Task.new task_params
    @task.subject_id = @subject.id
    if @task.save
      flash[:success] = t "activerecord.controllers.supervisor.tasks.create_task"
      redirect_to supervisor_task_path @task
    else
      render :new
    end
  end

  private

  def load_subject
    @subject = Subject.find params[:id]
  end

  def task_params
    params.require(:task).permit :name, :content
  end
end
