# Remove favorite boolean from students
class RemoveFavoriteFromStudents < ActiveRecord::Migration[5.1]
  def change
    remove_column :students, :favorite, :boolean
  end
end
