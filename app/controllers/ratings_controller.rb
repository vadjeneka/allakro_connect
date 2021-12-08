class RatingsController < ApplicationController

  def new
    @product = Product.includes(:store).find(params[:product_id])
    @store = @product.store
    @user = current_user
    # @rating = current_user.@product.store.ratings(rating_params)
  end
  
  def create
    @product = Product.includes(:store).find(params[:product_id])
    @rate = @product.ratings.build(rating_params.merge(user_id: current_user.id))
    if @rate.save
      redirect_to user_store_product_path(current_user, @product.store, @product), notice: "Produit noté avec succès!"
    end
  end

  private
  def rating_params
    params.require(:rating).permit( 
      :rates,
      :product_id,
    )
  end
end
