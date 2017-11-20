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

ActiveRecord::Schema.define(version: 20171119070023) do

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
    t.index ["email"], name: "index_carriers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_carriers_on_reset_password_token", unique: true
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

  create_table "locations", force: :cascade do |t|
    t.bigint "facility_id"
    t.bigint "shipment_id"
    t.string "commodity"
    t.integer "weight"
    t.string "is_for"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_locations_on_facility_id"
    t.index ["shipment_id"], name: "index_locations_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer "distance"
    t.integer "rate"
    t.string "commodity"
    t.integer "weight"
    t.string "car_type"
    t.bigint "shipper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_shippers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_shippers_on_reset_password_token", unique: true
  end

  add_foreign_key "facilities", "shippers"
  add_foreign_key "locations", "facilities"
  add_foreign_key "locations", "shipments"
  add_foreign_key "shipments", "shippers"
end
