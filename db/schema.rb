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

ActiveRecord::Schema.define(version: 20140828010238) do

  create_table "combis", force: true do |t|
    t.integer  "kensa_id"
    t.integer  "disease_id"
    t.string   "rank"
    t.string   "parent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "combis", ["parent"], name: "index_combis_on_parent", type: :fulltext

  create_table "diseases", force: true do |t|
    t.string   "flag"
    t.string   "name"
    t.string   "icd"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diseases", ["description"], name: "index_diseases_on_description", type: :fulltext

  create_table "kensas", force: true do |t|
    t.string   "flag"
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kensas", ["name"], name: "index_kensas_on_name", type: :fulltext

end
