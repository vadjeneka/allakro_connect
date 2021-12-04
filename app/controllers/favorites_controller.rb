class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
    @favorites = Favorite.where(user_id: current_user.id, still_favorites?: true)
  end
end
