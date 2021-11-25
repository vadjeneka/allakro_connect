class Product < ApplicationRecord
  
  belongs_to :store 
  has_and_belongs_to_many :categories
  has_many_attached :product_backgrounds

  def all_categories=(names)
    self.categories = names.split(',').map do |name|
      Category.where(name: name.strip.downcase).first_or_create!
    end
  end

  def all_categories
    categories.map(&:name).join(', ')
  end

  
  def self.search(search)
    if search
      Product.joins(:categories).where(["(lower(products.name) LIKE ? and products.is_available = ? ) or lower(categories.name) LIKE ?", "%#{search.downcase}%",true,"%#{search.downcase}%"]).uniq
    else

    end
  end
end
