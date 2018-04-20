class User < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :staffs, dependent: :destroy
  has_many :questions, dependent: :destroy

  has_many :student_courses, dependent: :destroy, through: :students, source: :course
  has_many :instructor_courses, dependent: :destroy, through: :staffs, source: :course

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

  def enroll
    Student.create(user: user, course: self)
  end

  def unenroll
    student = Student.create(user: user, course: self)
    student.destroy if student
  end
end
