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

ActiveRecord::Schema.define(version: 20180425074432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carriers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
    t.string "post_code"
    t.string "prefecture"
    t.string "name_kanji"
    t.string "name_furigana"
    t.string "phone"
    t.string "ward"
    t.string "street"
    t.string "areas_covered", default: [], array: true
    t.string "favorite_products", default: [], array: true
    t.string "site_url"
    t.string "ceo_name"
    t.date "founded_date"
    t.string "capital"
    t.string "employee_numbers"
    t.text "company_description"
    t.string "specialties", default: [], array: true
    t.index ["email"], name: "index_carriers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_carriers_on_reset_password_token", unique: true
  end

  create_table "deals", force: :cascade do |t|
    t.bigint "shipment_id"
    t.bigint "carrier_id"
    t.string "deal_status"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id", "shipment_id"], name: "index_deals_on_carrier_id_and_shipment_id", unique: true
    t.index ["carrier_id"], name: "index_deals_on_carrier_id"
    t.index ["shipment_id"], name: "index_deals_on_shipment_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.bigint "shipment_id"
    t.string "company_name"
    t.string "prefecture"
    t.string "ward"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "post_code"
    t.string "street"
    t.string "time"
    t.index ["shipment_id"], name: "index_deliveries_on_shipment_id"
  end

  create_table "delivery_vehicles", force: :cascade do |t|
    t.string "size"
    t.string "vehicle_type"
    t.integer "quantity"
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_delivery_vehicles_on_deal_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.bigint "shipper_id"
    t.string "name"
    t.string "prefecture"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipper_id"], name: "index_facilities_on_shipper_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "price"
    t.bigint "deal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_items_on_deal_id"
  end

  create_table "pickups", force: :cascade do |t|
    t.bigint "shipment_id"
    t.string "company_name"
    t.string "prefecture"
    t.string "ward"
    t.string "category"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "post_code"
    t.string "street"
    t.string "time"
    t.integer "size_height"
    t.integer "size_width"
    t.integer "size_depth"
    t.integer "quantity"
    t.string "temperature"
    t.string "additional_info"
    t.index ["shipment_id"], name: "index_pickups_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "distance"
    t.integer "offer_rate"
    t.string "car_type"
    t.bigint "shipper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available"
    t.string "transit_status"
    t.date "duration_start"
    t.date "duration_end"
    t.string "frequency"
    t.index ["shipper_id"], name: "index_shipments_on_shipper_id"
  end

  create_table "shippers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company_name"
    t.string "post_code"
    t.string "prefecture"
    t.string "ward"
    t.string "street"
    t.string "industry"
    t.string "name_kanji"
    t.string "name_furigana"
    t.string "phone"
    t.index ["email"], name: "index_shippers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_shippers_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "load_capacity"
    t.string "vehicle_type"
    t.integer "quantity"
    t.bigint "carrier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type_specifications"
    t.string "feature"
    t.index ["carrier_id"], name: "index_vehicles_on_carrier_id"
  end

  add_foreign_key "deals", "carriers"
  add_foreign_key "deals", "shipments"
  add_foreign_key "deliveries", "shipments"
  add_foreign_key "delivery_vehicles", "deals"
  add_foreign_key "facilities", "shippers"
  add_foreign_key "items", "deals"
  add_foreign_key "pickups", "shipments"
  add_foreign_key "shipments", "shippers"
  add_foreign_key "vehicles", "carriers"
end
