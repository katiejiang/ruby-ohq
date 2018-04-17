class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.boolean :favorite

      t.timestamps
    end
  end
end
