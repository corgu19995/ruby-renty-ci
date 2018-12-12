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

ActiveRecord::Schema.define(version: 20181128032009) do

  create_table "bookings", force: :cascade do |t|
    t.string "token"
    t.integer "user_id"
    t.integer "car_id"
    t.datetime "bookingDate"
    t.string "pickup"
    t.datetime "pickupDate"
    t.string "deliverPlace"
    t.datetime "deliverDate"
    t.index ["car_id"], name: "index_bookings_on_car_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "brand"
    t.string "thumbnail"
    t.string "price"
    t.string "model"
    t.integer "rental"
    t.string "plate"
    t.integer "rating"
    t.integer "capacity"
    t.string "transmission"
    t.integer "doors"
    t.string "color"
    t.integer "kms"
    t.integer "rental_id"
    t.integer "type_vehicle_id"
    t.index ["rental_id"], name: "index_cars_on_rental_id"
    t.index ["type_vehicle_id"], name: "index_cars_on_type_vehicle_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "url"
    t.integer "car_id"
    t.index ["car_id"], name: "index_pictures_on_car_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.string "name"
  end

  create_table "type_vehicles", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
