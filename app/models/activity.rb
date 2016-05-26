class Activity < ActiveRecord::Base
  enum actiontype: [:CREATE_COURSE, :UPDATE_COURSE, :DESTROY_COURSE,
    :FINISH_COURSE, :CREATE_SUBJECT, :UPDATE_SUBJECT, :FINISH_SUBJECT]

  belongs_to :user
  belongs_to :course

  scope :activities_of_course,
    -> (target_id){where ("actiontype BETWEEN 0 AND 3 AND target_id = ?"), target_id}
end
