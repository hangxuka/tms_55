class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_activity_users = current_user.activities.timeline
        .paginate page: params[:page]
    end
  end

  def contact
  end

  def about
  end
end
