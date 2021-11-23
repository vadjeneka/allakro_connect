class HomeController < ApplicationController
  def index
      @result
    if params[:search]
      @result = Product.search(params[:search])
    else
    end
    @products = Product.all
    
  end

  def products_rand
    @articles = articles.all
    offset = rand(100)
    @products_rand = Product.offset(offset).limit(8)
    
  end
end
