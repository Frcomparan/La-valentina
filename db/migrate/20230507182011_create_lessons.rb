# frozen_string_literal: true

class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :lesson_number, null: false
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
