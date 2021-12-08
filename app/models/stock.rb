class Stock < ApplicationRecord
  belongs_to :product
  
  def self.decrement_quantity(line_items)
    @product = Product.find(line_items.product_id)
    @stock = @product.stock
    # raise line_items.inspect
    if @stock.quantity != 0 && line_items.inventory.quantity <= @stock.quantity
      new_quantity = @stock.quantity - line_items.inventory.quantity
      @stock.update(quantity: new_quantity)
    end 
    
  end
  
end
