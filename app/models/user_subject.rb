class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :course_subject

  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
end
