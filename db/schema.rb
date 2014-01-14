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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apis", id: false, force: true do |t|
    t.integer   "a_id",                     null: false
    t.string    "a_type"
    t.string    "a_key1"
    t.string    "a_key2"
    t.string    "a_key3"
    t.string    "a_endpoint"
    t.integer   "a_group"
    t.integer   "a_set_by"
    t.timestamp "a_updated",  precision: 6
  end

  create_table "groups", id: false, force: true do |t|
    t.integer  "g_id",         null: false
    t.string   "g_name"
    t.text     "g_logo"
    t.integer  "g_created_by"
    t.date     "g_created"
    t.datetime "g_updated"
  end

  create_table "incoming", id: false, force: true do |t|
    t.integer  "i_id",         null: false
    t.integer  "i_link"
    t.integer  "i_type"
    t.integer  "i_difference"
    t.integer  "i_total"
    t.datetime "i_created"
  end

  create_table "incoming_types", id: false, force: true do |t|
    t.integer  "i_t_id",      null: false
    t.string   "i_t_name"
    t.string   "i_t_notes"
    t.datetime "i_t_created"
  end

  create_table "link_tags", id: false, force: true do |t|
    t.integer   "l_t_id",                    null: false
    t.integer   "l_t_link"
    t.integer   "l_t_master"
    t.timestamp "l_t_created", precision: 6
  end

  create_table "links", id: false, force: true do |t|
    t.integer  "l_id",         null: false
    t.integer  "l_group"
    t.integer  "l_created_by"
    t.string   "l_title"
    t.string   "l_name"
    t.string   "l_source"
    t.string   "l_medium"
    t.string   "l_full_url"
    t.string   "l_short_url"
    t.date     "l_created"
    t.datetime "l_updated"
  end

  create_table "master_tags", id: false, force: true do |t|
    t.integer  "m_t_id",      null: false
    t.string   "m_t_name"
    t.integer  "m_t_group"
    t.datetime "m_t_created"
  end

  create_table "transactions", id: false, force: true do |t|
  end

  create_table "users", id: false, force: true do |t|
    t.integer  "u_id",         null: false
    t.string   "u_first_name"
    t.string   "u_last_name"
    t.string   "u_email"
    t.string   "u_password"
    t.integer  "u_group"
    t.datetime "u_updated"
  end

  add_index "users", ["u_id"], name: "User ID", unique: true, using: :btree

end