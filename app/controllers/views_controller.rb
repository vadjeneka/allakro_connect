class ViewsController < ApplicationController
  
  def show
    @products_view = Product.find(params[:id])
    abc = @product.view += 1
    @product.update(view: abc)
    end



end