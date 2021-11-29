class ProductsController < ApplicationController
  
  def index
    if params[:name]
      Search.create!(user_id:current_user.id,content:params[:name])
      @products = Product.search(params[:name])
    else
      @products = Product.includes(:store, :categories).where(is_available: true).sample(10)
    end

    @categories = category_returns
    @cities = cities_return
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
    @favorite = Favorite.find_user_favorite(current_user, @product) if current_user
    # @products_view = Product.find(params[:id])
    # abc = @product.view += 1
    # @product.update(view: abc)

  end

  def create
    @product = store.products.build(product_params)
    if @product.save
      redirect_to store_path(@product.store), notice: 'Product was successfully created'
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

  def like
    @already_like = Favorite.find_by(user_id: params[:user], product_id: params[:id])
    # raise @already_like.inspect
    if @already_like
      @already_like.update(still_favorites?: !@already_like.still_favorites?)
      if params[:source] == 'product'
        redirect_to product_path(params[:id])
      else
        redirect_to user_favorites_path(current_user)
      end
    else
      Favorite.create!(user_id:params[:user], product_id:params[:id], still_favorites?:true)
      if params[:source] == 'product'
        redirect_to product_path(params[:id])
      else
        redirect_to user_favorites_path(current_user)
      end
    end
  end


  private 

  def product_by_price(first_price,last_price)
    @all_product = Product.all
    @products = @all_product.where("price BETWEEN ? AND ?",first_price,last_price)
  end

  def category_returns
    # category = Category.where('name like ?', "%#{current_user.searches['content']}%").uniq
    category = []
    if category.length > 1
      if category.length > 7
        category
      else
        category = category + Category.all.sort_by {rand}[0,8]
        category = category.sort_by {rand}[0,7]
      end
    else
      Category.all.sort_by {rand}[0,7]
    end
  end

  def cities_return
    # city = Store.select(['city like ? ot town like ?',"%#{current_user.searches['content']}%","%#{current_user.searches.content}%"]).uniq
    city = []
    if city.length > 1
      if city.length > 7
        city
      else
        city = city + Store.all.sort_by {rand}[0,8]
        city = city.sort_by {rand}[0,7]
      end
    else
      Store.all.sort_by {rand}[0,5]
    end
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
