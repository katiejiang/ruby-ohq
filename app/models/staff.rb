# Staff model
class Staff < ApplicationRecord
  belongs_to :user
  belongs_to :course
end
