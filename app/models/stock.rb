class Stock < ApplicationRecord
  belongs_to :product
  
  def decrement_quantity(line_items)
    @product = Product.find_by(self.product.id)
    @stock = @product.stock.quantity

    if @product.stock != nil && line_items.quantity <= @product.stock.quantity
      @stock = @stock - line_items.quantity
    end 
    
  end
end
