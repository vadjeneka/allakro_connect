require 'faker'


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# u1 = User.first
# u2 = User.last

User.all.each do |user|
  Store.create!(name: Faker::Company.name, description: Faker::Lorem.paragraph, city: Faker::Demographic.demonym, town: Faker::Nation.capital_city, user_id: user.id).tap do |store|
    5.times do |x|
      numb = rand(1..2000)*500
      Product.create!(name: Faker::Commerce.brand, description: Faker::Lorem.paragraph, price: numb, weight: rand(1..100), is_available: [true, false].sample, store_id: store.id, all_categories: "#{Faker::Types.rb_string}, #{Faker::Types.rb_string}, #{Faker::Types.rb_string}, #{Faker::Types.rb_string}")
    end
  end
end