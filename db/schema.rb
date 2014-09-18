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

ActiveRecord::Schema.define(version: 20140513162948) do

  create_table "event_types", force: true do |t|
    t.string   "alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title",                              null: false
    t.text     "description"
    t.integer  "location_id"
    t.integer  "event_type_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "ical_uid"
    t.boolean  "to_import",          default: false
    t.string   "to_import_location"
  end

  create_table "events_teachers", force: true do |t|
    t.integer "teacher_id"
    t.integer "event_id"
  end

  create_table "imported_events", force: true do |t|
    t.string  "ical_uid"
    t.integer "event_id"
  end

  create_table "locations", force: true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "title"
    t.string   "city"
    t.string   "country"
  end

  create_table "teachers", force: true do |t|
    t.date     "started"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

end
