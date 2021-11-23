class StoresController < ApplicationController

  def index
    @store = user.store
  end

  def new
    @user = current_user
    @store = Store.new(user_id: params[:user_id])
  end

  def show
    id = params[:id]
    @store = Store.find(id)
    @products = @store.products
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to user_store_path(current_user,@store), notice: 'Store was successfully created'
    else
      flash[:error] = "Store could not be created"
      render 'new'
    end
  end

  def edit
    @store = user.store
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to user_store_path(current_user,@store), notice: 'Store updated successfully'
    else
      flash[:error] = 'Cannot update Store'
      render 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to user_stores_path(), notice: 'Store deleted successfully'
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
      :user_id,
      :background
    )
  end
end
