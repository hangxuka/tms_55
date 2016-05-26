class UserTask < ActiveRecord::Base
  enum status: [:start, :inprogress, :finished]

  belongs_to :user
  belongs_to :task
  belongs_to :user_subject
end
