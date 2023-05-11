# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :value, presence: true
  validates :value,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5,
                            message: 'La calificación debe estar entre 0 y 5' }
end
