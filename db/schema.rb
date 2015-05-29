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

ActiveRecord::Schema.define(version: 20150523212842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "app_credentials", force: :cascade do |t|
    t.integer  "credential_id"
    t.integer  "app_id"
    t.string   "encrypted_value"
    t.string   "text_value"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "key"
  end

  create_table "app_environment_credentials", force: :cascade do |t|
    t.integer  "credential_id"
    t.integer  "app_environment_id"
    t.string   "encrypted_value"
    t.string   "text_value"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "app_credential_id"
  end

  create_table "app_environment_resources", force: :cascade do |t|
    t.integer  "app_environment_id"
    t.integer  "app_resource_id"
    t.integer  "count"
    t.string   "ami_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "instance_type"
    t.string   "type"
    t.hstore   "settings"
  end

  add_index "app_environment_resources", ["app_environment_id"], name: "index_app_environment_resources_on_app_environment_id", using: :btree
  add_index "app_environment_resources", ["app_resource_id"], name: "index_app_environment_resources_on_app_resource_id", using: :btree

  create_table "app_environments", force: :cascade do |t|
    t.integer  "app_id"
    t.integer  "environment_id"
    t.string   "git_tag"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "domain"
  end

  add_index "app_environments", ["app_id"], name: "index_app_environments_on_app_id", using: :btree
  add_index "app_environments", ["environment_id"], name: "index_app_environments_on_environment_id", using: :btree

  create_table "app_resources", force: :cascade do |t|
    t.integer  "app_id"
    t.integer  "resource_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "ami_id"
  end

  add_index "app_resources", ["app_id"], name: "index_app_resources_on_app_id", using: :btree
  add_index "app_resources", ["resource_id"], name: "index_app_resources_on_resource_id", using: :btree

  create_table "apps", force: :cascade do |t|
    t.string   "name"
    t.string   "git_repo"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "apps", ["language_id"], name: "index_apps_on_language_id", using: :btree

  create_table "credentials", force: :cascade do |t|
    t.string   "key_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "environments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "output_logs", force: :cascade do |t|
    t.string   "name"
    t.text     "log",        default: ""
    t.string   "error"
    t.text     "stacktrace"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "resource_builds", force: :cascade do |t|
    t.integer  "resource_id"
    t.string   "cookbook_version"
    t.string   "git_tag"
    t.string   "ami_id"
    t.boolean  "current"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "resource_builds", ["resource_id"], name: "index_resource_builds_on_resource_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.string   "cookbook_url"
    t.integer  "language_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "ami_id"
  end

  add_index "resources", ["language_id"], name: "index_resources_on_language_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "settings", ["app_id"], name: "index_settings_on_app_id", using: :btree

  add_foreign_key "app_environment_resources", "app_environments"
  add_foreign_key "app_environment_resources", "app_resources"
  add_foreign_key "app_environments", "apps"
  add_foreign_key "app_environments", "environments"
  add_foreign_key "app_resources", "apps"
  add_foreign_key "app_resources", "resources"
  add_foreign_key "apps", "languages"
  add_foreign_key "resource_builds", "resources"
  add_foreign_key "resources", "languages"
end
