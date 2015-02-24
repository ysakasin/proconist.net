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

ActiveRecord::Schema.define(version: 20141209023311) do

  create_table "contests", force: true do |t|
    t.string "name",              null: false
    t.string "date",              null: false
    t.string "place",             null: false
    t.string "title",             null: false
    t.string "competition_title", null: false
    t.string "themed_title",      null: false
  end

  create_table "entrants", force: true do |t|
    t.integer "contest",      null: false
    t.integer "section",      null: false
    t.integer "registry_num", null: false
    t.string  "school",       null: false
    t.string  "production",   null: false
    t.integer "code"
    t.string  "code_url"
    t.integer "slide"
    t.string  "slide_url"
    t.string  "site_url"
    t.integer "sns"
    t.string  "name_in_sns"
    t.string  "sns_url"
    t.integer "result"
    t.string  "prize"
  end

  create_table "histories", force: true do |t|
    t.integer  "label",      null: false
    t.string   "title",      null: false
    t.string   "href",       null: false
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", id: false, force: true do |t|
    t.string  "id",                        null: false
    t.integer "position",      default: 0, null: false
    t.string  "name",                      null: false
    t.string  "password_hash",             null: false
    t.string  "password_salt",             null: false
    t.string  "icon"
    t.string  "school"
    t.string  "github"
    t.string  "bitbucket"
    t.string  "slideshare"
    t.string  "twitter"
    t.string  "facebook"
    t.string  "site_name"
    t.string  "site_url"
    t.string  "description"
  end

end
