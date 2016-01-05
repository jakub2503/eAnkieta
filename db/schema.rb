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

ActiveRecord::Schema.define(version: 20151008145707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lectures", force: :cascade do |t|
    t.string   "name"
    t.integer  "year"
    t.string   "semester"
    t.integer  "id_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "score_archives", force: :cascade do |t|
    t.integer  "lecture_id"
    t.decimal  "general_score",    precision: 4, scale: 3
    t.decimal  "tempo_score",      precision: 4, scale: 3
    t.decimal  "importance_score"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "number_of_votes"
  end

  add_index "score_archives", ["lecture_id"], name: "index_score_archives_on_lecture_id", using: :btree

  create_table "scores", force: :cascade do |t|
    t.integer  "id_survey"
    t.integer  "general_score"
    t.integer  "tempo_score"
    t.integer  "importance_score"
    t.string   "comment"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "index"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "elogin_info"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "token",      limit: 4, null: false
    t.datetime "start_date",           null: false
    t.datetime "end_date",             null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "lecture_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string   "token",      limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_foreign_key "score_archives", "lectures"
  add_foreign_key "scores", "surveys", column: "id_survey"
  add_foreign_key "surveys", "lectures"
end
