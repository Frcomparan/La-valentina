# frozen_string_literal: true

class Lesson < ApplicationRecord
  belongs_to :course
  has_many :comments, dependent: :destroy
  has_one_attached :cover
  has_one_attached :video
  has_many_attached :extras

  # Validation
  validates :title, :description, presence: true
  validates :cover, presence: { message: 'Debes agregar una minuatura a la clase' }
  validates :video, presence: { message: 'Debes un video a la clase' }
  validates :lesson_number, numericality: { message: 'El número de clase debe ser numerico' }

  # Custom validation
  validate :validate_cover
  validate :validate_video

  private

  def validate_cover
    return if cover && cover.content_type =~ (%r{^image/(jpeg|gif|png|bmp|jpg)$})

    errors.add(:cover, 'La imagen subida no es valida, solo se permiten: jpeg, pjpeg, gif, png, bmp')
  end

  def validate_video
    return if video && video.content_type =~ (%r{^video/(mp4|mov|mkv)$})

    errors.add(:video, 'El video subido no es valido, solo se permiten: mp4, mov o mkv')
  end
end
