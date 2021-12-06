class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
    @stores = Store.all
  end

  def new
    @user = current_user
    @store = Store.new(user_id: params[:user_id])
  end

  def show
    id = params[:id]
    @store = Store.find(id)
    @store_products = @store.products
    @comments = Comment.joins(:product).where('products.store_id = ?', current_user.store.id) if current_user && current_user.store
  end

  def create
    @store = current_user.build_store(store_params)
    if @store.save
      redirect_to store_path(@store), notice: 'Store was successfully created'
    else
      raise "You got errors here"
      flash[:error] = "Store could not be created"
      render 'new'
    end
  end

  def edit
    @store = current_user.store
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to profile_path(current_user), notice: 'Information de la boutique mis a jour'
    else
      flash[:error] = 'Cannot update Store'
      render 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to profile_path(current_user), notice: 'Boutique supprime'
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
