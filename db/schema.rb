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

ActiveRecord::Schema.define(version: 20141102133635) do

  create_table "entrantsm", id: false, force: true do |t|
    t.integer "id"
    t.string  "school",                   null: false
    t.string  "production",               null: false
    t.integer "section",                  null: false
    t.string  "media",       default: ""
    t.string  "media_urls",  default: ""
    t.integer "sns"
    t.string  "name_in_sns"
    t.string  "sns_url"
    t.integer "result"
    t.string  "prize"
  end

end
