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

ActiveRecord::Schema.define(version: 20141105151903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "kalibro_configurations", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "kalibro_ranges", force: :cascade do |t|
    t.float    "beginning"
    t.float    "end"
    t.string   "comments"
    t.integer  "reading_id"
    t.integer  "metric_configuration_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "kalibro_ranges", ["metric_configuration_id"], name: "index_kalibro_ranges_on_metric_configuration_id", using: :btree
  add_index "kalibro_ranges", ["reading_id"], name: "index_kalibro_ranges_on_reading_id", using: :btree

  create_table "metric_configurations", force: :cascade do |t|
    t.integer  "metric_snapshot_id"
    t.float    "weight"
    t.string   "aggregation_form"
    t.integer  "reading_group_id"
    t.integer  "kalibro_configuration_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "metric_snapshots", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.text     "description"
    t.string   "code"
    t.string   "metric_collector_name"
    t.string   "scope"
    t.text     "script"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "reading_groups", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "readings", force: :cascade do |t|
    t.string   "label"
    t.float    "grade"
    t.string   "color"
    t.integer  "reading_group_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "readings", ["reading_group_id"], name: "index_readings_on_reading_group_id", using: :btree

end
