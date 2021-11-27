class Product < ApplicationRecord
  
  belongs_to :store 
  has_one :stock
  has_many :bids
  has_many :favorites

  has_and_belongs_to_many :categories
  has_many_attached :product_backgrounds
  has_many :comments


  scope :filter_by_name, ->(name) {where('lower(name) LIKE ?', "%#{name}%")}
  scope :filter_by_category, -> (category) {joins(:categories).where('lower(categories.name) LIKE ?', "%#{category}%")}
  scope :filter_by_availability, -> {where(is_available: true)}
  scope :filter_by_price_range, ->(first_price, second_price) {where(['price BETWEEN ? AND ?', "#{first_price}", "#{second_price}"])}
  scope :filter_by_location, ->(location) {joins(:stores).where(["lower(stores.city) LIKE ? OR lower(stores.town) LIKE ? ", "#{location}", "#{location}"])}


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
      Product.joins(:categories).where(["lower(products.name) LIKE ? or lower(categories.name) LIKE ?", "%#{search.downcase}%","%#{search.downcase}%"]).where(is_available: true).uniq
    else

    end
  end

end
