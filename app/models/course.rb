class Course < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :staffs, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: :True

  def add_admin(user)
    Staff.create(user: user, course: self, admin: true)
  end

  def add_staff(user)
    Staff.create(user: user, course: self, admin: false)
  end

  def add_student(user)
    Student.create(user: user, course: self, favorite: true)
  end

  def queue
    questions.select{ |question| question[:status] != 'Resolved' }
  end
end
