class Score < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :value, presence: true
  validates :value, numericality: { greater_than: 0, less_than: 5, message: 'La calificación debe estar entre 0 y 5' }

end
