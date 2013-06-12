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

ActiveRecord::Schema.define(version: 20130611234004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "critic_opinions", force: true do |t|
    t.boolean  "like"
    t.integer  "user_id"
    t.integer  "critic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
  end

  create_table "critics", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "publication"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies", force: true do |t|
    t.string   "title"
    t.integer  "year"
    t.string   "description"
    t.integer  "rt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_opinions", force: true do |t|
    t.boolean  "like"
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
