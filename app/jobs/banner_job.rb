class BannerJob < ApplicationJob
  queue_as :default

  def perform
    @products = Product.all.sample(1)
    Tendance.creat(product) 
  end
end
