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

ActiveRecord::Schema.define(version: 20161001083248) do

  create_table "article_categories", force: :cascade do |t|
    t.string   "url",         null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "url",           null: false
    t.string   "title",         null: false
    t.text     "body",          null: false
    t.integer  "category_id",   null: false
    t.integer  "operator_id",   null: false
    t.string   "thumbnail_url", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "contests", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "date",              null: false
    t.string   "place",             null: false
    t.string   "title",             null: false
    t.string   "competition_title", null: false
    t.string   "themed_title",      null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "nth"
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "product_id",    null: false
    t.string   "document_type", null: false
    t.string   "url",           null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "operators", force: :cascade do |t|
    t.string   "identifier",                  null: false
    t.integer  "position",        default: 0, null: false
    t.string   "name",                        null: false
    t.string   "password_digest"
    t.string   "icon"
    t.integer  "school_id"
    t.string   "github"
    t.string   "bitbucket"
    t.string   "slideshare"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "site"
    t.string   "description"
    t.string   "email"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["identifier"], name: "index_operators_on_identifier", unique: true
  end

  create_table "prizes", force: :cascade do |t|
    t.integer  "product_id", null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "name"], name: "index_prizes_product_name_unique", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.integer  "contest_id", null: false
    t.integer  "section",    null: false
    t.integer  "school_id",  null: false
    t.string   "name",       null: false
    t.integer  "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
