class HomeController < ApplicationController
  def index
    if current_user
      if current_user.first_name == nil && current_user.town == nil && current_user.city == nil
        redirect_to edit_profile_path(current_user)
      end 
    end
    if params[:name]
      redirect_to products_path(name: params[:name])
    end
    @products = Product.all.includes(:store).sort_by {rand}[0,8]
    @tendance = Tendance.order(created_at: :desc).first
    @stores = Store.all.includes(:user).sort_by {rand}[0,4]
    @product_tendances = Product.all.includes(:store).reject{|product| @products.include?(product)}.sort_by {rand}[0,4]
  end

  private

  def products_rand
    @articles = articles.all
    offset = rand(100)
    @products_rand = Product.offset(offset).limit(8)
    
  end

  # def tendances
  #   first_cat = []
  #   product = nil
  #   second_cat = Rating.includes(:product).where('rates > ?', 3).order(rates: :desc).take(10)
  #   if second_cat.length >1
  #     product = second_cat.sample.product
  #   else
  #     product = Product.all.sample
  #   end
  #   Tendance.create(id:product.id, start_time:Time.now, end_time:Time.now)
  #   # third_cat = Order.all.where('rates')

  # end
end
