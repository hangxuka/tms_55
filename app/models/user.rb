class User < ActiveRecord::Base
  include ActivityActionable

  enum role: [:trainee, :supervisor, :admin]

  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :following_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_subjects, dependent: :destroy
  has_many :course_subjects, through: :user_subjects
  has_many :user_tasks, dependent: :destroy
  has_many :subjects, through: :user_subjects
  has_many :tasks, through: :user_tasks

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}

  before_save :email_downcase

  after_update :update_activity

  has_secure_password

  def correct_user? user
    self == user
  end

  def follow other_user
    active_relationships.create following_id: other_user.id
    create_activity self.id, other_user.id, Activity.actiontypes[:follow]
  end

  def unfollow other_user
    active_relationships.find_by(following_id: other_user.id).destroy
    create_activity id, other_user.id, Activity.actiontypes[:unfollow]
  end

  def following_other_user? other_user
    following.include? other_user
  end

  private
  def email_downcase
    self.email = email.downcase
  end

  def update_activity
    create_activity id, id, Activity.actiontypes[:update_profile]
  end
end
