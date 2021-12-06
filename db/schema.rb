# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_04_170358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.integer "balance", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bids", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "initial_price"
    t.string "state", default: "waiting"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "validated", default: false
    t.index ["product_id"], name: "index_bids_on_product_id"
  end

  create_table "carts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "store_id"
    t.boolean "validated", default: false
    t.index ["store_id"], name: "index_carts_on_store_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories_products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.uuid "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id", "product_id"], name: "index_categories_products_on_category_id_and_product_id", unique: true
    t.index ["category_id"], name: "index_categories_products_on_category_id"
    t.index ["product_id", "category_id"], name: "index_categories_products_on_product_id_and_category_id", unique: true
    t.index ["product_id"], name: "index_categories_products_on_product_id"
  end

  create_table "chats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.uuid "user_id", null: false
    t.uuid "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_chats_on_store_id"
    t.index ["user_id", "store_id"], name: "index_chats_on_user_id_and_store_id", unique: true
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "product_id", null: false
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "product_id", null: false
    t.boolean "still_favorites?", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_favorites_on_product_id"
    t.index ["user_id", "product_id"], name: "index_favorites_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "inventories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "bid_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bid_id"], name: "index_inventories_on_bid_id"
  end

  create_table "line_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.integer "quantity", default: 1
    t.uuid "cart_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.uuid "user_id", null: false
    t.uuid "chat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "actor_id"
    t.string "notify_type", null: false
    t.string "target_type"
    t.uuid "message_id", null: false
    t.uuid "chat_id", null: false
    t.string "second_target_type"
    t.string "third_target_type"
    t.bigint "third_target_id"
    t.boolean "read_at", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_notifications_on_actor_id"
    t.index ["chat_id"], name: "index_notifications_on_chat_id"
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["user_id", "notify_type"], name: "index_notifications_on_user_id_and_notify_type"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "offers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "bid_id", null: false
    t.uuid "user_id", null: false
    t.integer "amount"
    t.boolean "accepted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bid_id"], name: "index_offers_on_bid_id"
    t.index ["user_id"], name: "index_offers_on_user_id"
  end

  create_table "orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "cart_id", null: false
    t.integer "amount"
    t.string "state", default: "waiting"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.integer "weight"
    t.boolean "is_available", default: true
    t.uuid "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "ratings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "product_id", null: false
    t.integer "rates"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_ratings_on_product_id"
    t.index ["user_id", "product_id"], name: "index_ratings_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "searches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "stocks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "stores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "city"
    t.string "town"
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "tendances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_tendances_on_product_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type_transaction"
    t.integer "amount"
    t.uuid "account_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "city"
    t.string "town"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "views", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "product_id", null: false
    t.uuid "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_views_on_product_id"
    t.index ["user_id"], name: "index_views_on_user_id"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bids", "products"
  add_foreign_key "carts", "stores"
  add_foreign_key "carts", "users"
  add_foreign_key "categories_products", "categories"
  add_foreign_key "categories_products", "products"
  add_foreign_key "chats", "stores"
  add_foreign_key "chats", "users"
  add_foreign_key "comments", "products"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "products"
  add_foreign_key "favorites", "users"
  add_foreign_key "inventories", "bids"
  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "products"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "chats"
  add_foreign_key "notifications", "messages"
  add_foreign_key "notifications", "users"
  add_foreign_key "offers", "bids"
  add_foreign_key "offers", "users"
  add_foreign_key "orders", "carts"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "stores"
  add_foreign_key "ratings", "products"
  add_foreign_key "ratings", "users"
  add_foreign_key "searches", "users"
  add_foreign_key "stocks", "products"
  add_foreign_key "stores", "users"
  add_foreign_key "tendances", "products"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "views", "products"
  add_foreign_key "views", "users"
end
