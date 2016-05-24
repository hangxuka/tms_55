class CourseSubject < ActiveRecord::Base
  enum status: [:start, :trainning, :finished]

  belongs_to :subject
  belongs_to :course
end
