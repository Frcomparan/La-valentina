class Score < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :value, presence: true
  validates :description, length: { minimum: 1, message: 'No puedes dejar un comentario vacío'  }
end
