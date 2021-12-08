class Product < ApplicationRecord
  belongs_to :store 
  has_one :stock, :dependent => :destroy
  has_many :bids, :dependent => :destroy
  has_many :favorites, :dependent => :destroy

  has_and_belongs_to_many :categories
  has_many_attached :product_backgrounds, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :tendances, :dependent => :destroy


  scope :filter_by_name, ->(name) {joins(:categories).where(["lower(products.name) LIKE ? or lower(categories.name) LIKE ?", "%#{name.downcase}%","%#{name.downcase}%"])}
  scope :filter_by_category, -> (category) {joins(:categories).where('lower(categories.name) LIKE ?', "#{category.downcase}")}
  scope :filter_by_availability, -> {where(is_available: true)}
  scope :filter_by_price_range, ->(first_price, second_price) {where(['price BETWEEN ? AND ?', "#{first_price}", "#{second_price}"])}
  scope :filter_by_location, ->(location) {joins(:store).where(["lower(stores.city) LIKE ? or lower(stores.town) LIKE ? ", "#{location.downcase}", "#{location.downcase}"])}


  def all_categories=(names)
    self.categories = names.split(',').uniq.map do |name|
      Category.where(name: name.strip.downcase).first_or_create!
    end
  end

  def all_categories
    categories.map(&:name).join(', ')
  end

  def self.filter_by_categories(categories)
    query = self
    count = 0
    categories.each do |category|
      if count == 0
        query = query.filter_by_category(category)
      else
        query = query.or(self.filter_by_category(category))
      end
      count += 1
    end
    query
  end

  def self.filter_by_locations(locations)
    query = self
    count = 0
    locations.each do |location|
      if count == 0
        query = query.filter_by_location(location)
      else
        query = query.or(self.filter_by_location(location))
      end
      count += 1
    end
    query
  end


end
