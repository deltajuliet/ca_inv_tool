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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121030192113) do

  create_table "inventory_items", :force => true do |t|
    t.string   "auction_title"
    t.string   "inventory_number"
    t.integer  "total_quantity"
    t.float    "weight"
    t.string   "upc"
    t.string   "asin"
    t.string   "mpn"
    t.text     "description"
    t.string   "brand"
    t.decimal  "starting_bid"
    t.decimal  "seller_cost"
    t.decimal  "buy_it_now_price"
    t.decimal  "retail_price"
    t.decimal  "channel_advisor_store_price"
    t.decimal  "second_chance_offer_price"
    t.string   "picture_urls"
    t.integer  "received_in_inventory"
    t.string   "labels"
    t.string   "flag"
    t.string   "classification"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

end
