class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.text :text
      t.boolean :waiting
      t.boolean :done
      t.datetime :created_at

      t.timestamps
    end
  end
end
