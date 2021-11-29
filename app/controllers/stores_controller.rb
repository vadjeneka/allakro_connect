class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @store = Store.all
  end

  def new
    @user = current_user
    @store = Store.new(user_id: params[:user_id])
  end

  def show
    # raise params.inspect
    id = params[:id]
    @store = Store.find(id)
    @store_products = @store.products
    @comments = Comment.joins(:product).where('products.store_id = ?', current_user.store.id)
  end

  def create
    # raise store_params[:background].inspect
    @store = current_user.build_store(store_params)
    if @store.save
      # raise "You here"
      redirect_to store_path(@store), notice: 'Store was successfully created'
    else
      raise "You got errors here"
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
      :background
    )
  end
end
