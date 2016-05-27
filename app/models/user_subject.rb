class UserSubject < ActiveRecord::Base
  include ActivityActionable

  enum status: [:start, :inprogress, :finished]

  belongs_to :user
  belongs_to :subject
  belongs_to :course_subject

  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks

  after_update :finish_activity

  accepts_nested_attributes_for :user_tasks,
   reject_if: :all_blank

  delegate :name, :start_date, :end_date, to: :subject, prefix: true

  private
  def finish_activity
    create_activity self.user_id, id, Activity.actiontypes[:finish_subject]
  end
end
