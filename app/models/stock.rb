class Stock < ApplicationRecord
  belongs_to :product
  
  def decrement_quantity(line_items)
    @product = Product.find(line_items.product_id)
    @stock = @product.stock

    if @stock.quantity != 0 && line_items.quantity <= @stock.quantity
      new_quantity = @stock.quantity - line_items.quantity
      @stock.update(quantity: new_quantity)
    end 
    
  end
  
end
