class StoresController < ApplicationController

  def index
    @stores = user.stores
  end

  def new
    @store = user.stores.build
  end

  def show
    id = params[:id]
    @store = Store.find(id)
  end

  def create
    @store = current_user.stores.build(store_params)
    if @store.save
      redirect_to users_path(current_user), notice: 'Store was successfully created'
    else
      flash[:error] = "Store could not be created"
      render 'new'
    end
  end

  def edit
    @store = user.stores.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(stor_params)
      redirect_to users_path(current_user), notice: 'Store updated successfully'
    else
      flash[:error] = 'Cannot update Store'
      render 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to users_path(current_user), notice: 'Store deleted successfully'
  end


  private 

  def user
    @user ||= User.find(params[:user_id])
  end
  
  def store_params
    params.require(:store).permit(
      :name,
      :description,
      :city,
      :town,
      :to_date,
      :user_id
    )
  end
end
