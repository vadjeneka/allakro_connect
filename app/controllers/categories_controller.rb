class CategoriesController < ApplicationController
  def show
    @products = Category.includes(:products).find(params[:id]).products
  end
end
