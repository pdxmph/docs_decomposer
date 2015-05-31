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

ActiveRecord::Schema.define(version: 20150531211704) do

  create_table "areas", force: :cascade do |t|
    t.string   "name"
    t.integer  "priority"
    t.string   "work"
    t.integer  "frequency"
    t.integer  "support"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "writer_coverage"
    t.text     "description"
    t.text     "rendered_description"
    t.string   "slug"
  end

  add_index "areas", ["slug"], name: "index_areas_on_slug", unique: true

  create_table "areas_users", id: false, force: :cascade do |t|
    t.integer "area_id"
    t.integer "user_id"
  end

  add_index "areas_users", ["area_id", "user_id"], name: "areas_users_index", unique: true

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "page_id"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "rendered_content"
  end

  create_table "elements", force: :cascade do |t|
    t.string   "kind"
    t.integer  "page_id"
    t.string   "filename"
    t.text     "content"
    t.string   "checksum"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "nearest_heading"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "filename"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "risk"
    t.integer  "priority"
    t.integer  "version_id"
    t.string   "slug"
    t.integer  "cached_votes_total",        default: 0
    t.integer  "cached_votes_score",        default: 0
    t.integer  "cached_votes_up",           default: 0
    t.integer  "cached_votes_down",         default: 0
    t.integer  "cached_weighted_score",     default: 0
    t.integer  "cached_weighted_total",     default: 0
    t.float    "cached_weighted_average",   default: 0.0
    t.integer  "user_id"
    t.string   "subtitle"
    t.text     "frontmatter"
    t.text     "rendered_markdown_content"
    t.text     "markdown_content"
    t.boolean  "reviewed",                  default: false
  end

  add_index "pages", ["cached_votes_down"], name: "index_pages_on_cached_votes_down"
  add_index "pages", ["cached_votes_score"], name: "index_pages_on_cached_votes_score"
  add_index "pages", ["cached_votes_total"], name: "index_pages_on_cached_votes_total"
  add_index "pages", ["cached_votes_up"], name: "index_pages_on_cached_votes_up"
  add_index "pages", ["cached_weighted_average"], name: "index_pages_on_cached_weighted_average"
  add_index "pages", ["cached_weighted_score"], name: "index_pages_on_cached_weighted_score"
  add_index "pages", ["cached_weighted_total"], name: "index_pages_on_cached_weighted_total"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "display_name"
    t.boolean  "versioned"
    t.string   "slug"
  end

  add_index "projects", ["slug"], name: "index_projects_on_slug", unique: true

  create_table "repos", force: :cascade do |t|
    t.string   "name"
    t.string   "uri"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "ssh_clone_url"
    t.boolean  "private"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fullname"
    t.boolean  "admin"
    t.string   "jira_name"
    t.boolean  "super",                  default: false
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "version_number"
    t.integer  "project_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "branch"
    t.string   "source_repo"
    t.boolean  "active"
    t.string   "version_directory"
    t.string   "slug"
  end

  add_index "versions", ["project_id"], name: "index_versions_on_project_id"
  add_index "versions", ["slug"], name: "index_versions_on_slug", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
