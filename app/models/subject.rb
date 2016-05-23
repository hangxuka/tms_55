class Subject < ActiveRecord::Base
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :tasks, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_greate_or_equal_than_start_date
  accepts_nested_attributes_for :tasks, reject_if: :all_blank

  private
  def end_date_greate_or_equal_than_start_date
    if start_date.nil? || end_date.nil?
      errors.add(:start_date, I18n.t("aplication.errors.subject.nil_date"))
    elsif start_date > end_date
      errors.add(:start_date, I18n.t("aplication.errors.subject.start_end"))
    end
  end
end
