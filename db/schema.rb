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

ActiveRecord::Schema.define(version: 20160610074814) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "linked_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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

  create_table "commits", force: :cascade do |t|
    t.integer  "repository_id"
    t.integer  "author_id"
    t.string   "sha"
    t.integer  "stamp"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "gerrit_changes", force: :cascade do |t|
    t.string   "kind"
    t.string   "id_from_gerrit"
    t.string   "project"
    t.string   "branch"
    t.string   "change_id"
    t.string   "subject"
    t.string   "status"
    t.string   "created"
    t.string   "updated"
    t.boolean  "mergeable"
    t.string   "sortkey"
    t.integer  "number"
    t.integer  "gerrit_owner_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "gerrit_code_reviews", force: :cascade do |t|
    t.string   "change_id_from_gerrit"
    t.integer  "gerrit_change_id"
    t.integer  "gerrit_owner_id"
    t.integer  "value"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "gerrit_messages", force: :cascade do |t|
    t.string   "message_id"
    t.string   "date"
    t.string   "message"
    t.integer  "revision_number"
    t.integer  "gerrit_owner_id"
    t.integer  "gerrit_change_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "gerrit_owners", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gerrit_sanity_reviews", force: :cascade do |t|
    t.string   "change_id_from_gerrit"
    t.integer  "gerrit_change_id"
    t.integer  "gerrit_owner_id"
    t.integer  "value"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "pid"
    t.integer  "uid"
    t.integer  "tid"
    t.string   "content"
    t.string   "timestamp"
    t.integer  "reputation"
    t.integer  "votes"
    t.string   "edited"
    t.boolean  "deleted"
    t.integer  "index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repositories", force: :cascade do |t|
    t.string   "name"
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
