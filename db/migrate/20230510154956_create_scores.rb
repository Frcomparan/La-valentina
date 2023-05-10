class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.decimal :value, null: false, precision: 5, scale: 2
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
