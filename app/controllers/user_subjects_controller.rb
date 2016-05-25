class UserSubjectsController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :load_user_subject, only: [:show, :update, :edit]

  def show
    @user_subjects = current_user.user_subjects
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
    params.require(:user_subject).permit :subject_id, :user_id,
      :course_subject_id, :status
  end
end
