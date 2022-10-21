class ProductsController < ApplicationController
  
  def index
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
    # if params[:name]
    #   @products = Product.search(params[:name])
    # else
    # @products = Product.all
    @products = Product.includes(:store, :categories).filter_by_availability.page(params[:page]).per(12)
    @products = @products.filter_by_name(params[:name]) if params[:name].present?
    @products = @products.filter_by_price_range(params[:price][:min], params[:price][:max]) if params.has_key?(:price) && params[:price][:min].present? && params[:price][:max].present?
    @products = @products.filter_by_categories(params[:categories]) if params[:categories].present?
    @products = @products.filter_by_locations(params[:locations]) if params[:locations].present?
    Search.create!(user_id:current_user.id,content:params[:name]) if params[:name].present? && current_user
    # end

    @categories = category_returns
    @cities = cities_return

    @search_infos = { 
      min_price: params.dig(:price, :min),
      max_price: params.dig(:price, :max),
      categories: (params.dig(:categories) || []) ,
      locations: (params.dig(:locations) || [])
    }

  end

  
  def new
    @store = Store.find(params[:store_id])
    @user = current_user  
    @product = @store.products.build      
  end

  def show
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
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
    # raise product_params.inspect
    @product = store.products.build(product_params)
    if @product.save
      @store = @product.store
      if (params[:product][:quantity]).to_i >= 0
        stock = @product.build_stock(quantity: (params[:product][:quantity]).to_i)        
      else
        stock = @product.build_stock(quantity:0)
      end
      if stock.save
        redirect_to store_path(@product.store), notice: 'Produit créé avec succès!'
      else
        raise stock.errors.inspect
      end
    else
      flash[:error] = "Le produit ne peut être créé!"
      render 'new'
    end
  end

  def edit
    @store = Store.find(params[:store_id])
    @product = store.products.find(params[:id])
  end

  def update
    # list_img = product_params[:hidden_items].split(',').map(&:to_i)
    @product = Product.find(params[:id])
    # list_img.each do |img|
    #   @product.product_backgrounds[img].destroy
    # end
    if @product.update(product_params)
      # @product.product_backgrounds_attachments.where(id: image_ids).delete_all
      redirect_to store_product_path(@product.store, @product), notice: 'Produit mis à jour avec succès!'
    else
      flash[:error] = 'Le produit ne peut être mis à jour!'
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @store = @product.store
    @product.destroy
    redirect_to store_path(@store), notice: 'Produit supprimé avec succès!'
  end

  def like
    @already_like = Favorite.find_by(user_id: params[:user], product_id: params[:id])
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
    res = ActiveRecord::Base.connection.execute('select count(categories_products.product_id) as count, categories_products.category_id from categories_products join products on products.id = categories_products.product_id where products.is_available = true group by categories_products.category_id order by count desc limit 10;')
    category = res.map{|r| r['category_id']}
    Category.where(id:category)
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
      Store.all.take(5)
    end
  end
  
  

  def store
    @store ||= Store.find(params[:store_id])
  end
  
  def product_params
    # raise params.inspect
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :weight,
      :all_categories,
      :store_id,
      :is_available,
      product_backgrounds: []
    )
  end
end
