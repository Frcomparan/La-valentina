class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :courses, through: :cart_items
  belongs_to :user

  def sub_total
    sum = 0
    self.cart_items.each do |cart_item|
      sum+= cart_item.course.price
    end
    return sum
  end

  def total_courses
    return self.cart_items.length
  end
end
