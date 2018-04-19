class Course < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :staffs, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: :True
end
