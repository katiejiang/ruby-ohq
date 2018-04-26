# Create staff table
class CreateStaffs < ActiveRecord::Migration[5.1]
  def change
    create_table :staffs do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.boolean :admin

      t.timestamps
    end
  end
end
