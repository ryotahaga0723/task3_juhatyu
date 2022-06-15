# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_15_040942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "postcode", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "town", null: false
    t.string "address", null: false
    t.string "building"
    t.string "room_number"
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "approvals", force: :cascade do |t|
    t.bigint "approval", default: 0, null: false
    t.bigint "user_id", null: false
    t.string "approvalable_type", null: false
    t.bigint "approvalable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["approvalable_type", "approvalable_id"], name: "index_approvals_on_approvalable_type_and_approvalable_id"
    t.index ["user_id"], name: "index_approvals_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_categories_on_company_id"
  end

  create_table "companies", primary_key: "code", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.datetime "arrive_date", null: false
    t.string "delivery_company", null: false
    t.bigint "delivery_number", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_deliveries_on_order_id"
  end

  create_table "invoice_contents", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "set", null: false
    t.bigint "price", null: false
    t.bigint "quantity", null: false
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_invoice_contents_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "code", null: false
    t.bigint "user_id", null: false
    t.bigint "order_id", null: false
    t.bigint "total_sum"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_invoices_on_order_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "order_supplies", force: :cascade do |t|
    t.boolean "availability", default: false, null: false
    t.bigint "quantity", null: false
    t.bigint "order_id", null: false
    t.bigint "supply_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_supplies_on_order_id"
    t.index ["supply_id"], name: "index_order_supplies_on_supply_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "code", null: false
    t.date "date", null: false
    t.bigint "total_price"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "content"
    t.bigint "company_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.date "date", null: false
    t.string "what", null: false
    t.string "do", null: false
    t.bigint "check_list", default: 0, null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_schedules_on_order_id"
  end

  create_table "shippings", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_shippings_on_order_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.bigint "status", default: 0, null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_statuses_on_order_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "quantity", null: false
    t.bigint "company_id", null: false
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_stocks_on_company_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "supplies", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.bigint "price", null: false
    t.bigint "set", null: false
    t.string "content"
    t.bigint "product_id", null: false
    t.bigint "stock_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_supplies_on_product_id"
    t.index ["stock_id"], name: "index_supplies_on_stock_id"
  end

  create_table "telephones", force: :cascade do |t|
    t.string "number", null: false
    t.string "telephoneable_type", null: false
    t.bigint "telephoneable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["telephoneable_type", "telephoneable_id"], name: "index_telephones_on_telephoneable_type_and_telephoneable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "admin", default: false, null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_users_on_company_id"
  end

end
