class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: User.name
  belongs_to :following, class_name: User.name

  validates :follower, presence: true
  validates :following, presence: true
end
