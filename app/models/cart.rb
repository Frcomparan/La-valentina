class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :courses, through: :cart_items
  belongs_to :user

  scope :filter_by_date_lower, -> { order :created_at }
  scope :filter_by_date_higher, -> { order created_at: :desc }

  def sub_total
    sum = 0
    self.cart_items.each do |cart_item|
      sum+= cart_item.course.price
    end
    return sum
  end

  def self.search_filter(filtering_param)
    results = self.where(status: 1)
    return results.sort { |x, y| x.sub_total <=> y.sub_total } if filtering_param == 'price_lower'
    return results.sort { |x, y| y.sub_total <=> x.sub_total } if filtering_param == 'price_higher'
    results = results.public_send("filter_by_#{filtering_param}")
    results
  end

  def total_courses
    return self.cart_items.length
  end
end
