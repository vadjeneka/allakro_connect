class ProductsController < ApplicationController
  
  def index
    if params[:search]
      @products = Product.search(params[:search])
    else
      @products = Product.includes(:store, :categories).where(is_available: true)
    end
  end

  
  def new
    @store = Store.find(params[:store_id])
    @user = current_user  
    @product = @store.products.build
  end

  def show
    id = params[:id]
    @product = Product.find(id)
    @store = @product.store
    @comment = Comment.new

    # @products_view = Product.find(params[:id])
    # abc = @product.view += 1
    # @product.update(view: abc)

  end

  def create
    @product = store.products.build(product_params)
    if @product.save
      redirect_to user_store_path(current_user, current_user.store.id), notice: 'Product was successfully created'
    else
      flash[:error] = "Product could not be created"
      render 'new'
    end
  end

  def edit
    @store = Store.find(params[:store_id])
    @user = current_user  
    @product = store.products.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to user_stores_path(), notice: 'Product updated successfully'
    else
      flash[:error] = 'Cannot update Product'
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to user_stores_path(), notice: 'Product deleted successfully'
  end


  private 

  def product_by_price(first_price,last_price)
    @all_product = Product.all
    @products = @all_product.where("price BETWEEN ? AND ?",first_price,last_price)
  end

  

  def store
    @store ||= Store.find(params[:store_id])
  end
  
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :weight,
      :all_categories,
      :store_id,
      :is_available,
      product_backgrounds:[]
    )
  end
end
