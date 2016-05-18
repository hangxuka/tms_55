class Supervisor::SubjectsController < ApplicationController
  before_action :find_subject, only: [:show]

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def show
  end

  private
  def find_subject
    @subject = Subject.find params[:id]
  end
end
