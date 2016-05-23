class UserTask < ActiveRecord::Base
  enum status: [:start, :trainning, :finished]

  belongs_to :user
  belongs_to :task
  belongs_to :user_subject
end
