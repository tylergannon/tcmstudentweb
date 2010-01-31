# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100119173202) do

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contraindications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dui_yao_herbs", :force => true do |t|
    t.integer  "dui_yao_id"
    t.integer  "herb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dui_yaos", :force => true do |t|
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flavors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_categories", :force => true do |t|
    t.string   "name"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_contraindications", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "contraindication_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_dui_yaos", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "dui_yao_id"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_herbs", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "herb_id"
    t.integer  "formula_role_id"
    t.string   "dose"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_patterns", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "pattern_id"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_pulse_qualities", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "pulse_quality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_roles", :force => true do |t|
    t.string   "pinyin"
    t.string   "english"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_symptoms", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "symptom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_therapeutic_functions", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "therapeutic_function_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_tongue_qualities", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "tongue_quality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formulas", :force => true do |t|
    t.string   "pinyin"
    t.string   "english"
    t.text     "preparation"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "formula_category_id"
    t.string   "chinese"
  end

  create_table "herb_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herb_channels", :force => true do |t|
    t.integer  "herb_id"
    t.integer  "channel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herb_flavors", :force => true do |t|
    t.integer  "herb_id"
    t.integer  "flavor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herb_therapeutic_functions", :force => true do |t|
    t.integer  "herb_id"
    t.integer  "therapeutic_function_id"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herbs", :force => true do |t|
    t.integer  "herb_category_id"
    t.string   "pinyin"
    t.string   "english"
    t.string   "latin"
    t.text     "commentary"
    t.text     "contraindications"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "chinese"
  end

  create_table "patterns", :force => true do |t|
    t.string   "name"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pulse_qualities", :force => true do |t|
    t.string   "name"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "symptoms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "therapeutic_functions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tongue_qualities", :force => true do |t|
    t.string   "name"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
