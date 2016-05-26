class UserTasksController < ApplicationController
  before_action :logged_in_user
  before_action :load_user_task, only: [:update]


  def update
    if @user_task.update_attributes user_task_params
      flash[:success] = t "user_subjects.success"
      redirect_to :back
    else
      flash[:danger] = t "user_subjects.errors"
    end
  end

  private
  def load_user_task
    @user_task = UserTask.find params[:id]
  end

  def user_task_params
    params.require(:user_task).permit :user_id, :task_id,
      :user_subject_id, :status
  end
end
