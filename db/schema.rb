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

ActiveRecord::Schema.define(version: 20140320064703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acupuncture_channels", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnosis_patterns", force: true do |t|
    t.string   "name"
    t.string   "commentary"
    t.string   "citation_id"
    t.string   "tongue"
    t.string   "pulse"
    t.string   "slug"
    t.string   "canonical"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "references_authors", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "references_citations", force: true do |t|
    t.integer  "source_id"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "references_textbooks", force: true do |t|
    t.integer  "author_id"
    t.string   "title"
    t.string   "slug"
    t.string   "year"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "references_textbooks", ["author_id"], name: "index_references_textbooks_on_author_id", using: :btree

end
