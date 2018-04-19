class Question < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :user, presence: true
  validates :course, presence: true
  validates :text, presence: true

  def status_color
    return 'positive' if status == 'Being helped'
    return 'warning' if status == 'Waiting'
  end
end
