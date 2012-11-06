# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121106045806) do

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lunch_comments", :force => true do |t|
    t.string   "text"
    t.string   "name"
    t.integer  "lunch_id"
    t.integer  "rating_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lunch_comments", ["lunch_id"], :name => "index_lunch_comments_on_lunch_id"
  add_index "lunch_comments", ["rating_id"], :name => "index_lunch_comments_on_rating_id"

  create_table "lunches", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "genre_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "lunches", ["genre_id"], :name => "index_lunches_on_genre_id"
  add_index "lunches", ["restaurant_id"], :name => "index_lunches_on_restaurant_id"

  create_table "ratings", :force => true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "telephoneNumber"
    t.boolean  "reservation"
    t.string   "memo"
    t.string   "url"
    t.string   "email"
    t.boolean  "sundayUp"
    t.boolean  "mondayUp"
    t.boolean  "tuesdayUp"
    t.boolean  "wednesdayUp"
    t.boolean  "thursdayUp"
    t.boolean  "fridayUp"
    t.boolean  "saturdayUp"
    t.time     "startTime"
    t.time     "endTime"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
