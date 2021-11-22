class Product < ApplicationRecord
  belongs_to :store 
  has_and_belongs_to_many :categories

  def self.search(search)
    if search
      Product.joins(:categories).where(["lower(products.name) LIKE ? or lower(categories.name) LIKE ?", "%#{search.downcase}%","%#{search.downcase}%"]).uniq
    else

    end
  end
end
