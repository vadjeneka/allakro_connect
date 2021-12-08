class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :store
  
  has_one :order, :dependent => :destroy
  
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items, :dependent => :destroy


  def add_product(product)
    line_item = line_items.build(cart_id: self.id, product_id: product.id)
    line_item.save
  end

  def remove_product(product)
    line_item = self.line_items.find_by(cart_id: self.id, product_id: product.id)
    line_item.destroy
  end

  def total_price
    sum = 0
    self.line_items.each do |line_item|
      sum += line_item.total_price
    end
    sum
  end
end
