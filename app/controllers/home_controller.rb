class HomeController < ApplicationController
  def index
      @result
    if params[:search]
      @result = Product.search(params[:search])
    else
    end
  end
end

 
