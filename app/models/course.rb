class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons
  has_one_attached :cover

  # Validations
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0, message: 'El precio debe ser mayor a 0' }

  # Custom validation
  validate :validate_cover

  private
  def validate_cover
    unless cover and cover.content_type =~ /^image\/(jpeg|pjpeg|gif|png|bmp)$/
      errors.add(:cover, "La imagen subida no es valida")
    end
  end
end
