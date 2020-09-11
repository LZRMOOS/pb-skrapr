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

ActiveRecord::Schema.define(version: 2020_09_09_225126) do

  create_table "listings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "category"
    t.string "price"
    t.date "original_post_date"
    t.date "last_repost_date"
    t.string "sale_status"
    t.integer "view_count"
    t.integer "watch_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "search_id"
    t.index ["search_id"], name: "index_listings_on_search_id"
  end

  create_table "searches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "last_synch_at"
    t.integer "staleness", default: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "listings", "searches"
end
