class User < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :staffs, dependent: :destroy
  has_many :enrolled_courses, through: :students
  has_many :staffed_courses, through: :staffs

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validate :valid_email

  def valid_email
    return unless email
    errors.add(:email, "must have an '@' and a '.'") unless email.include?('@') && email.include?('.')
  end
end
