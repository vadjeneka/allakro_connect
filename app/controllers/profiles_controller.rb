class ProfilesController < ApplicationController
  def show
    @favorites = Favorite.where(user_id: current_user.id, still_favorites?: true)
  end
end
