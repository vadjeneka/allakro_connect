class CartsController < ApplicationController
  def index
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
    @carts = current_user.carts.includes(:line_items, :products).where(validated: false)
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to user_carts_path(current_user), success: 'Votre panier à été supprimé avec succès!' # TODO: Redirect to cart path
  end
end