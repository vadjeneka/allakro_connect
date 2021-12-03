class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @orders = Order.where(user_id: current_user.id)
    @favorites = Favorite.where(user_id: current_user.id, still_favorites?: true)
  end

  def edit
    current_user
  end

  def update
    # raise params.inspect
    if current_user.update(profile_params)
      redirect_to profile_path(current_user), notice: 'Profile updated successfully'
    else
      raise current_user.errors.inspect
      flash[:error] = 'Cannot update Store'
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