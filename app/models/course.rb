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

  def update_to_staff(user)
    staff = Staff.find_by(user: user, course: self)
    if staff
      staff.update({ admin: false })
      print 'UPDATTTEEEDD WOOOOO' if staff.save
    end
  end

  def remove_staff(user)
    staff = Staff.find_by(user: user, course: @course)
    staff.destroy
  end

  def add_student(user)
    Student.create(user: user, course: self)
  end

  def queue
    questions.select{ |question| question[:status] != 'Resolved' }
  end
end
