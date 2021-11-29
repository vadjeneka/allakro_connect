class ProfilesController < ApplicationController
  # before_action :authenticate_user!
  def show
    # @comments = Comment.joins(:product).where('products.store_id = ?', current_user.store.id)
    @favorites = Favorite.where(user_id: current_user.id, still_favorites?: true)
  end

end
