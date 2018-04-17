class RemoveDoneFromQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :done, :boolean
  end
end
