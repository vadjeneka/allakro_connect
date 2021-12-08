class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
    @orders = Order.where(user_id: current_user.id)
    @favorites = Favorite.where(user_id: current_user.id, still_favorites?: true)
  end

  def edit
    current_user
  end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path(current_user), notice: 'Profil mis à jour avec succès!'
    else
      raise current_user.errors.inspect
      flash[:error] = 'Le store ne peut être mis à jour!'
      render 'edit'
    end
  end


  private 

  def profile_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone, 
      :town , 
      :city, 
      :password, 
      :password_confirmation, 
      :avatar
    )
  end
end