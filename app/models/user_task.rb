class UserTask < ActiveRecord::Base
  include ActivityActionable

  enum status: [:start, :trainning, :finished]

  belongs_to :user
  belongs_to :task
  belongs_to :user_subject

  after_update :finish_activity

  private
  def finish_activity
    create_activity self.user_id, id, Activity.actiontypes[:finish_task]
  end
end
