class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @favorites = Favorite.where(user_id: current_user.id, still_favorites?: true)
    @account = Account.find_by(user_id: current_user.id) 
  end
end