class Course < ActiveRecord::Base
  enum status: [:pending, :starting, :finished]

  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects

  validates :name, presence: true, length: {maximum: 50}
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate  :end_date_greate_or_equal_than_start_date

  accepts_nested_attributes_for :user_courses, allow_destroy: true
  accepts_nested_attributes_for :course_subjects,
   reject_if: :all_blank, allow_destroy: true

  private
  def end_date_greate_or_equal_than_start_date
    if start_date.nil? || end_date.nil?
      errors.add(:start_date, I18n.t("aplication.errors.course.blank"))
    elsif start_date > end_date
      errors.add :start_date, I18n.t("aplication.errors.course.start_end")
    end
  end
end
