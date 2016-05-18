class Supervisor::SubjectsController < ApplicationController
  def index
    @subjects = Subject.paginate page: params[:page]
  end
end
