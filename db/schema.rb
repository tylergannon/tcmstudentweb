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

ActiveRecord::Schema.define(version: 20140321165409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "acupuncture_channels", force: true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "acupuncture_channels", ["slug"], name: "index_acupuncture_channels_on_slug", using: :btree

  create_table "acupuncture_points", force: true do |t|
    t.integer  "channel_id"
    t.integer  "position"
    t.string   "pinyin"
    t.string   "chinese"
    t.string   "name_discussion"
    t.string   "commentary",      limit: 65500
    t.string   "canonical"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acupuncture_points", ["channel_id"], name: "index_acupuncture_points_on_channel_id", using: :btree

  create_table "clinic_patients", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "practitioner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clinic_practitioners", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clinic_practitioners", ["confirmation_token"], name: "index_clinic_practitioners_on_confirmation_token", unique: true, using: :btree
  add_index "clinic_practitioners", ["email"], name: "index_clinic_practitioners_on_email", unique: true, using: :btree
  add_index "clinic_practitioners", ["reset_password_token"], name: "index_clinic_practitioners_on_reset_password_token", unique: true, using: :btree
  add_index "clinic_practitioners", ["unlock_token"], name: "index_clinic_practitioners_on_unlock_token", unique: true, using: :btree

  create_table "clinic_visits", force: true do |t|
    t.integer  "patient_id"
    t.datetime "appointment_time"
    t.string   "slug"
    t.integer  "practitioner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clinic_visits", ["patient_id"], name: "index_clinic_visits_on_patient_id", using: :btree
  add_index "clinic_visits", ["practitioner_id"], name: "index_clinic_visits_on_practitioner_id", using: :btree
  add_index "clinic_visits", ["slug"], name: "index_clinic_visits_on_slug", using: :btree

  create_table "diagnosis_pattern_symptoms", force: true do |t|
    t.integer  "pattern_id"
    t.integer  "symptom_id"
    t.string   "commentary",  limit: 65500
    t.boolean  "maybe"
    t.boolean  "key_symptom"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "diagnosis_pattern_symptoms", ["pattern_id"], name: "index_diagnosis_pattern_symptoms_on_pattern_id", using: :btree
  add_index "diagnosis_pattern_symptoms", ["symptom_id"], name: "index_diagnosis_pattern_symptoms_on_symptom_id", using: :btree

  create_table "diagnosis_patterns", force: true do |t|
    t.string   "name"
    t.string   "commentary",  limit: 65500
    t.integer  "citation_id"
    t.string   "tongue"
    t.string   "pulse"
    t.string   "slug"
    t.string   "canonical"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagnosis_symptoms", force: true do |t|
    t.string   "name"
    t.string   "slug"
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
    t.string   "source_type"
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

  create_table "treatment_point_prescription_points", force: true do |t|
    t.integer  "point_prescription_id"
    t.integer  "point_id"
    t.string   "reason"
    t.string   "commentary",            limit: 65500
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "treatment_point_prescription_points", ["point_id"], name: "index_point_prescription_point_id", using: :btree
  add_index "treatment_point_prescription_points", ["point_prescription_id"], name: "index_point_prescription_pp_id", using: :btree

  create_table "treatment_point_prescriptions", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "commentary",  limit: 65500
    t.integer  "citation_id"
    t.integer  "pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "treatment_point_prescriptions", ["citation_id"], name: "index_treatment_point_prescriptions_on_citation_id", using: :btree
  add_index "treatment_point_prescriptions", ["pattern_id"], name: "index_treatment_point_prescriptions_on_pattern_id", using: :btree

end
