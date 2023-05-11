# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons
  has_many :scores
  has_one_attached :cover

  # Validations
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0, message: 'El precio debe ser mayor a 0' }

  # Custom validation
  validate :validate_cover

  def rating
    scores = self.scores
    (scores.reduce(0) { |sum, score| sum += score.value } / scores.length).round(2)
  end

  def rated?(user_id)
    scores.where(user_id:).length.positive?
  end

  private

  def validate_cover
    return if cover && cover.content_type =~ (%r{^image/(jpeg|pjpeg|gif|png|bmp)$})

    errors.add(:cover, 'La imagen subida no es valida')
  end
end
