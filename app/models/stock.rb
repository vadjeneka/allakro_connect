class Stock < ApplicationRecord
  belongs_to :
  
  def decrement_quantity(line_items)
    @product = Product.find(params[:product_id])
    @stock = @product.stock.quantity

    if @product.stock != nil && line_items.quantity <= @product.stock.quantity
      @stock = @stock - line_items.quantity
    end 
    
  end
end
