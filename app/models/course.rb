class Course < ApplicationRecord
  belongs_to :user
  has_one_attached :cover

  validate :validate_cover

  private
  def validate_cover
    unless cover and cover.content_type =~ /^image\/(jpeg|pjpeg|gif|png|bmp)$/
      errors.add(:cover, "La imagen subida no es valida")
    end
  end
end
