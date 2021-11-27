class BannerJob < ApplicationJob
  queue_as :default

  def perform
    first_cat = []
    product = nil
    second_cat = Rating.includes(:product).where('rates > ?', 3).order(rates: :desc).take(10)
    if second_cat.length >1
      product = second_cat.sample.product
    else
      product = Product.all.sample
    end
    Tendance.create!(product_id:product.id, start_time:Time.now, end_time:Time.now+1.day)
  end
end
