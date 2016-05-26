class UserCourse < ActiveRecord::Base
  include ActivityActionable

  enum status: [:pending, :starting, :finished]

  belongs_to :user
  belongs_to :course

  after_update :finish_activity

  private
  def finish_activity
    create_activity self.user_id, id, Activity.actiontypes[:finish_course]
  end
end
