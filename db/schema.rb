# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_05_17_003133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string "name", null: false
    t.string "size", null: false
    t.decimal "cost", default: "0.0"
    t.decimal "sale_price", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 0
    t.index ["name", "size"], name: "index_accessories_on_name_and_size", unique: true
  end

  create_table "accessory_compatibilities", force: :cascade do |t|
    t.integer "stuffed_animal_id"
    t.integer "accessory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_accessory_compatibilities_on_accessory_id"
    t.index ["stuffed_animal_id", "accessory_id"], name: "stuffed_animal_accessory_index", unique: true
    t.index ["stuffed_animal_id"], name: "index_accessory_compatibilities_on_stuffed_animal_id"
  end

  create_table "custom_products", force: :cascade do |t|
    t.integer "order_id", null: false
    t.decimal "price", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_custom_products_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "completed_at"
    t.decimal "total", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stuffed_animals", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "cost", default: "0.0"
    t.decimal "sale_price", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 0
  end

end
