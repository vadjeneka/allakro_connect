class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @orders = Order.where(user_id: current_user.id)
    @favorites = Favorite.where(user_id: current_user.id, still_favorites?: true)
  end

end