class Question < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :user, presence: true
  validates :course, presence: true
  validates :text, presence: true
end
