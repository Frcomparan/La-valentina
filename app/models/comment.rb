class Comment < ApplicationRecord
  belongs_to :lesson
  belongs_to :user

  validates :content presence: true
  validates :content, length: { minimum: 1, message: 'No puedes dejar un comentario vacío'  }

end
