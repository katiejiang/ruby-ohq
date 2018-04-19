class User < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :staffs, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validate :valid_email

  def valid_email
    return unless email
    errors.add(:email, "must have an '@' and a '.'") unless email.include?('@') && email.include?('.')
  end

  def is_admin?(course)
    return !Staff.find_by(user: self, course: course, admin: true).nil?
  end

  def is_staff?(course)
    return !Staff.find_by(user: self, course: course).nil?
  end

  def is_student?(course)
    return !Student.find_by(user: self, course: course).nil?
  end
end
