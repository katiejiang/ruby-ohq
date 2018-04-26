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
  validates_confirmation_of :password, message: 'does not match. Please try again!'

  def valid_email
    return unless email
    errors.add(:email, "must have an '@' and a '.'") unless email.include?('@') && email.include?('.')
  end

  def admin?(course)
    !Staff.find_by(user: self, course: course, admin: true).nil?
  end

  def staff?(course)
    !Staff.find_by(user: self, course: course).nil?
  end

  def student?(course)
    !Student.find_by(user: self, course: course).nil?
  end

  def enroll(course)
    Student.create(user: self, course: course)
  end

  def unenroll(course)
    student = Student.find_by(user: self, course: course)
    student.destroy if student
  end

  def name_email
    "#{name} (#{email})"
  end
end
