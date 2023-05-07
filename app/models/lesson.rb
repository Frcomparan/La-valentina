# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :course
  has_one_attached :cover
  has_one_attached :video

  # Validation
  validates :title, :description, presence: true
  validates :lesson_number, numericality: { message: 'El número de clase debe ser numerico' }

  # Custom validation
  validate :validate_cover
  validate :validate_video

  private

  def validate_cover
    return if cover && cover.content_type =~ (%r{^image/(jpeg|pjpeg|gif|png|bmp)$})

    errors.add(:cover, 'La imagen subida no es valida')
  end

  def validate_video
    print "\n\n\n\n\n #{video.content_type} \n\n\n\n\n"
    return if video && video.content_type =~ (%r{^video/(mp4|mov)$})

    errors.add(:video, 'El video subido no es valido')
  end
end
