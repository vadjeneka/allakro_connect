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
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
    id = params[:id]
    @store = Store.find(id)
    @store_products = @store.products
    @comments = Comment.joins(:product).where('products.store_id = ?', current_user.store.id) if current_user && current_user.store
  end

  def create
    @store = current_user.build_store(store_params)
    if @store.save
      redirect_to store_path(@store), notice: 'Le store à été créé avec succès!'
    else
      flash[:error] = "Le store ne peut être créé"
      render 'new'
    end
  end

  def edit
    @store = current_user.store
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to profile_path(current_user), notice: 'Information de la boutique mis à jour'
    else
      flash[:error] = 'Le store ne peut être mis à jour!'
      render 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to profile_path(current_user), notice: 'Boutique supprimée'
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
