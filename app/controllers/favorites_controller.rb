class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    @favorites = Favorite.where(user_id: current_user.id, still_favorites?: true)
  end
end
