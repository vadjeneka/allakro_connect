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

jack_albert = User.create!(
  first_name: "Jack",
  last_name: "Albert",
  email: "jackalbert@mail.com",
  phone: "2250102030405",
  city: "Abidjan",
  town: "Cocody",
  password: '000000',
  password_confirmation:'000000'
)

ane_marion = User.create!(
  first_name: "Ane",
  last_name: "Ane",
  email: "anemarion@mail.com",
  phone: "2250102030405",
  city: "Abidjan",
  town: "Cocody",
  password: '000000',
  password_confirmation:'000000'
)

ibrahim_nouho = User.create!(
  first_name: "Ibrahim",
  last_name: "Nouho",
  email: "ibrahimnouho123@gmail.com",
  phone: "2250102030405",
  city: "Abidjan",
  town: "Abobo",
  password: '000000',
  password_confirmation:'000000'
)

mederic_gbagba = User.create!(
  first_name: "Médéric",
  last_name: "Gbagba",
  email: "medericjoel@gmail.com",
  phone: "2250102030405",
  city: "Yakro",
  town: "Yakro",
  password: '000000',
  password_confirmation:'000000'
)

User.create!(
  first_name: 'admin', 
  last_name: 'admin', 
  email: 'admin@techshelter.fr', 
  password: '000000', 
  password_confirmation: '000000',
  town: 'Cocody',
  city: 'Abidjan',
  phone: '0102030405'
)

jack_store = Store.create!(name: "La maison des lumières", description: Faker::Lorem.paragraph, city: jack_albert.city, town: jack_albert.town, user_id: jack_albert.id)
js1 = Product.create!(name: "Luminaires murales", description: Faker::Lorem.paragraph, price: 120000, weight: rand(1..100), is_available: true, store_id: jack_store.id, all_categories: "lumiere, murale, maison, moderne")
Stock.create!(product_id: js1.id, quantity: rand(1..100))
js1 = Product.create!(name: "Lustre moderne", description: Faker::Lorem.paragraph, price: 80000, weight: rand(1..100), is_available: true, store_id: jack_store.id, all_categories: "lumiere, murale, maison, moderne, lustre")
Stock.create!(product_id: js1.id, quantity: rand(1..100))

ane_marion = Store.create!(name: "WAX & Co.", description: Faker::Lorem.paragraph, city: ane_marion.city, town: ane_marion.town, user_id: ane_marion.id)
am1 = Product.create!(name: "Chapeau en pagne", description: Faker::Lorem.paragraph, price: 35000, weight: rand(1..100), is_available: true, store_id: ane_marion.id, all_categories: "wax, pagne, moderne, chapeau")
Stock.create!(product_id: am1.id, quantity: rand(1..100))
am2 = Product.create!(name: "Montre en pagne", description: Faker::Lorem.paragraph, price: 12000, weight: rand(1..100), is_available: true, store_id: ane_marion.id, all_categories: "wax, pagne, moderne, montre, style")
Stock.create!(product_id: am2.id, quantity: rand(1..100))
am3 = Product.create!(name: "Chaise en pagne", description: Faker::Lorem.paragraph, price: 80000, weight: rand(1..100), is_available: true, store_id: ane_marion.id, all_categories: "wax, pagne, moderne, chaise, maison")
Stock.create!(product_id: am3.id, quantity: rand(1..100))
am4 = Product.create!(name: "Sac en pagne", description: Faker::Lorem.paragraph, price: 18000, weight: rand(1..100), is_available: true, store_id: ane_marion.id, all_categories: "wax, pagne, moderne, sac, style")
Stock.create!(product_id: am4.id, quantity: rand(1..100))

ibrahim_nouho = Store.create!(name: "Masques Africains", description: Faker::Lorem.paragraph, city: ibrahim_nouho.city, town: ibrahim_nouho.town, user_id: ibrahim_nouho.id)
in1 = Product.create!(name: "Masque Baoulé", description: Faker::Lorem.paragraph, price: 235000, weight: rand(1..100), is_available: true, store_id: ibrahim_nouho.id, all_categories: "masque, afrique, moderne, decoration, moderne, style, art")
Stock.create!(product_id: in1.id, quantity: rand(1..100))
in2 = Product.create!(name: "Masque Senoufo", description: Faker::Lorem.paragraph, price: 238000, weight: rand(1..100), is_available: true, store_id: ibrahim_nouho.id, all_categories: "masque, afrique, moderne, decoration, moderne, style, art")
Stock.create!(product_id: in2.id, quantity: rand(1..100))

mederic_gbagba = Store.create!(name: "Peintures, Sculptures & Co.", description: Faker::Lorem.paragraph, city: mederic_gbagba.city, town: mederic_gbagba.town, user_id: mederic_gbagba.id)
mg1 = Product.create!(name: "Harmonies", description: Faker::Lorem.paragraph, price: 635000, weight: rand(1..100), is_available: true, store_id: mederic_gbagba.id, all_categories: "peinture, moderne, decoration, moderne, style, art")
Stock.create!(product_id: mg1.id, quantity: rand(1..100))
mg2 = Product.create!(name: "Beauté et visages", description: Faker::Lorem.paragraph, price: 535000, weight: rand(1..100), is_available: true, store_id: mederic_gbagba.id, all_categories: "peinture, moderne, decoration, moderne, style, art")
Stock.create!(product_id: mg2.id, quantity: rand(1..100))