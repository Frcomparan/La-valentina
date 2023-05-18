# frozen_string_literal: true

class AddColumnToCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :visibility, :integer, default: 0
  end
end
