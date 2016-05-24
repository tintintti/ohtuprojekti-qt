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

ActiveRecord::Schema.define(version: 20160524101037) do

  create_table "categories", force: :cascade do |t|
    t.integer  "cid"
    t.string   "name"
    t.string   "description"
    t.string   "slug"
    t.string   "parentCid"
    t.integer  "topic_count"
    t.integer  "post_count"
    t.boolean  "disabled"
    t.integer  "order"
    t.string   "link"
    t.integer  "numRecentReplies"
    t.integer  "totalPostCount"
    t.integer  "totalTopicCount"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "pid"
    t.integer  "uid"
    t.integer  "tid"
    t.string   "content"
    t.string   "timestamp"
    t.integer  "reputation"
    t.integer  "votes"
    t.integer  "edited"
    t.boolean  "deleted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.integer  "tid"
    t.integer  "uid"
    t.integer  "cid"
    t.integer  "mainPid"
    t.string   "title"
    t.string   "slug"
    t.string   "timestamp"
    t.string   "lastposttime"
    t.integer  "postcount"
    t.integer  "viewcount"
    t.boolean  "locked"
    t.boolean  "pinned"
    t.integer  "isQuestion"
    t.integer  "isSolved"
    t.string   "relativeTime"
    t.string   "lastposttimeISO"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "userslug"
    t.string   "email"
    t.string   "picture"
    t.string   "fullname"
    t.string   "signature"
    t.integer  "reputation"
    t.integer  "postcount"
    t.boolean  "banned"
    t.string   "status"
    t.integer  "uid"
    t.string   "lastonline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
