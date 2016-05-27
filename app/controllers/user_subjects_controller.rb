class UserSubjectsController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :load_user_subject, only: [:show, :update, :edit]

  def show
    @tasks = @subject.tasks
    @user_id = @user_subject.user_id
    @tasks.each do |task|
      @user_subject.user_tasks.find_or_initialize_by task_id: task.id,
        user_id: @user_id
    end
  end

  def edit
  end

  def update
    if @user_subject.update_attributes user_subject_params
      flash[:success] = t "user_subjects.success"
      redirect_to :back
    else
      flash[:danger] = t "user_subjects.errors"
    end
  end

  private
  def load_user_subject
    @user_subject = UserSubject.find params[:id]
    @subject = @user_subject.subject
  end

  def user_subject_params
    params.require(:user_subject).permit :user_id, :subject_id, :course_subject_id, :status,
      user_tasks_attributes: [:id, :user_id, :status, :task_id]
  end
end
