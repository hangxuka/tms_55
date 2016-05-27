class Activity < ActiveRecord::Base
  enum actiontype: [:create_course, :update_course, :destroy_course,
    :finish_course, :create_subject, :update_subject, :finish_subject,
    :follow, :unfollow, :update_profile, :finish_task]

  belongs_to :user
  belongs_to :course

  scope :activities_of_course,
    -> (target_id){where ("actiontype BETWEEN 0 AND 3 AND target_id = ?"), target_id}
  scope :timeline, ->{order created_at: :desc}
end
