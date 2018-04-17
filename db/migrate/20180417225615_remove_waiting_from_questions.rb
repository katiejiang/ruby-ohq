class RemoveWaitingFromQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :waiting, :boolean
  end
end
