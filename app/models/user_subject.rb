class UserSubject < ActiveRecord::Base
  enum status: [:start, :inprogress, :finished]

  belongs_to :user
  belongs_to :subject
  belongs_to :course_subject

  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks

  accepts_nested_attributes_for :user_tasks, reject_if: :all_blank

  delegate :name, :start_date, :end_date, to: :subject, prefix: true
end
