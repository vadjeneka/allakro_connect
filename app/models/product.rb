class Product < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :categories

  # def all_categories=(names)
  #   self.categories = names.split(',').map do |name|
  #     Category.where(name: name.strip.downcase).first_or_create!
  #   end
  # end

  # def all_categories
  #   categories.map(&:name).join(', ')
  # end

end
