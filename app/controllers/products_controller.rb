class ProductsController < ApplicationController


  def show
    offset = rand(100)
     @meta_title = "Mypage #{@product.title}"
     @meta_description = @product.description
     @products_rand = Product.offset(offset).limit(8)
   end

  private
   def set_product
    @product = Product.find(params[:id])
   end

  def product_params
    params.require(:product).permit(:title, :description, :image, :category_id, :stock_quantity, :label_id, :query, :slug)
  end

end
