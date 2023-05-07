class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, null: false, precision: 7, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
