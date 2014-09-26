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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140926020038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "karma_gifts", force: true do |t|
    t.integer  "giver_id"
    t.integer  "receiver_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "mood"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "password"
    t.string   "name"
    t.string   "email"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "avatar_url"
    t.integer  "karma_total", default: 0
    t.integer  "karma_bank",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
