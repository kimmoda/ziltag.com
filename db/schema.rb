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

ActiveRecord::Schema.define(version: 20151001092007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content",    null: false
    t.integer  "user_id",    null: false
    t.integer  "ziltag_id",  null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree
  add_index "comments", ["ziltag_id"], name: "index_comments_on_ziltag_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "image",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "source"
    t.string   "href"
    t.string   "slug",       null: false
  end

  add_index "photos", ["href"], name: "index_photos_on_href", using: :btree
  add_index "photos", ["slug"], name: "index_photos_on_slug", using: :btree
  add_index "photos", ["source"], name: "index_photos_on_source", unique: true, using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "username"
    t.string   "cover"
    t.string   "type"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "ziltags", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.decimal  "x",          null: false
    t.decimal  "y",          null: false
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug",       null: false
  end

  add_index "ziltags", ["photo_id"], name: "index_ziltags_on_photo_id", using: :btree
  add_index "ziltags", ["slug"], name: "index_ziltags_on_slug", using: :btree
  add_index "ziltags", ["user_id"], name: "index_ziltags_on_user_id", using: :btree

  add_foreign_key "comments", "users"
  add_foreign_key "comments", "ziltags"
  add_foreign_key "photos", "users"
  add_foreign_key "ziltags", "photos"
  add_foreign_key "ziltags", "users"
end
