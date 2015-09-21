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

ActiveRecord::Schema.define(version: 20150921151526) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collectings", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "collectable_id",   null: false
    t.string   "collectable_type", null: false
  end

  add_index "collectings", ["collectable_type", "collectable_id"], name: "index_collectings_on_collectable_type_and_collectable_id", using: :btree
  add_index "collectings", ["user_id", "collectable_id", "collectable_type"], name: "index_collectings_on_user_id_and_collectable", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content",    null: false
    t.integer  "user_id",    null: false
    t.integer  "ziltag_id",  null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree
  add_index "comments", ["ziltag_id"], name: "index_comments_on_ziltag_id", using: :btree

  create_table "followings", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "leader_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "followings", ["follower_id", "leader_id"], name: "index_followings_on_follower_id_and_leader_id", unique: true, using: :btree
  add_index "followings", ["leader_id", "follower_id"], name: "index_followings_on_leader_id_and_follower_id", unique: true, using: :btree

  create_table "libpuzzle_signatures", force: :cascade do |t|
    t.integer "photo_id"
    t.binary  "signature"
  end

  add_index "libpuzzle_signatures", ["photo_id"], name: "index_libpuzzle_signatures_on_photo_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "image",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "source"
    t.string   "path"
    t.string   "slug",       null: false
  end

  add_index "photos", ["path"], name: "index_photos_on_path", using: :btree
  add_index "photos", ["slug"], name: "index_photos_on_slug", using: :btree
  add_index "photos", ["source"], name: "index_photos_on_source", unique: true, using: :btree
  add_index "photos", ["user_id"], name: "index_photos_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                      null: false
    t.text     "content",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "published",  default: false, null: false
  end

  add_index "posts", ["title"], name: "index_posts_on_title", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "stickers", force: :cascade do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.integer  "x",          null: false
    t.integer  "y",          null: false
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stickers", ["photo_id"], name: "index_stickers_on_photo_id", using: :btree
  add_index "stickers", ["user_id"], name: "index_stickers_on_user_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscribers", ["email"], name: "index_subscribers_on_email", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_id_and_taggable_type", unique: true, using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

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

  create_table "ziltaggings", force: :cascade do |t|
    t.integer  "x",                null: false
    t.integer  "y",                null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "photo_id",         null: false
    t.integer  "ziltaggable_id",   null: false
    t.string   "ziltaggable_type", null: false
  end

  add_index "ziltaggings", ["photo_id"], name: "index_ziltaggings_on_photo_id", using: :btree
  add_index "ziltaggings", ["ziltaggable_type", "ziltaggable_id"], name: "index_ziltaggings_on_ziltaggable_type_and_ziltaggable_id", using: :btree

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

  add_foreign_key "collectings", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "ziltags"
  add_foreign_key "followings", "users", column: "follower_id"
  add_foreign_key "followings", "users", column: "leader_id"
  add_foreign_key "photos", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "ziltaggings", "photos"
  add_foreign_key "ziltags", "photos"
  add_foreign_key "ziltags", "users"
end
