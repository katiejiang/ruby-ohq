# Add status string to questions
class AddStatusToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :status, :string
  end
end
