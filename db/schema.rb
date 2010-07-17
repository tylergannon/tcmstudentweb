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

ActiveRecord::Schema.define(:version => 20100717160331) do

  create_table "acu_point_categories", :force => true do |t|
    t.integer  "acu_point_id"
    t.integer  "category_id"
    t.integer  "position"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "acu_point_categories", ["acu_point_id"], :name => "index_acu_point_categories_on_acu_point_id"
  add_index "acu_point_categories", ["category_id"], :name => "index_acu_point_categories_on_category_id"

  create_table "acu_point_categories_channels", :id => false, :force => true do |t|
    t.integer "acu_point_category_id"
    t.integer "channel_id"
  end

  add_index "acu_point_categories_channels", ["acu_point_category_id"], :name => "index_acu_point_categories_channels_on_acu_point_category_id"
  add_index "acu_point_categories_channels", ["channel_id"], :name => "index_acu_point_categories_channels_on_channel_id"

  create_table "acu_point_infos", :force => true do |t|
    t.integer  "acu_point_id"
    t.string   "english"
    t.text     "commentary"
    t.integer  "citation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.string   "needling"
  end

  add_index "acu_point_infos", ["acu_point_id"], :name => "index_acu_point_infos_on_acu_point_id"
  add_index "acu_point_infos", ["citation_id"], :name => "index_acu_point_infos_on_citation_id"

  create_table "acu_point_symptoms", :force => true do |t|
    t.integer  "symptom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "key_symptom"
    t.boolean  "maybe"
    t.text     "commentary"
    t.integer  "acu_point_info_id"
    t.integer  "position"
  end

  add_index "acu_point_symptoms", ["acu_point_info_id"], :name => "index_acu_point_symptoms_on_acu_point_info_id"
  add_index "acu_point_symptoms", ["symptom_id"], :name => "index_acu_point_symptoms_on_symptom_id"

  create_table "acu_point_therapeutic_functions", :force => true do |t|
    t.integer  "therapeutic_function_id"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "acu_point_info_id"
    t.integer  "position"
  end

  add_index "acu_point_therapeutic_functions", ["acu_point_info_id"], :name => "index_acu_point_therapeutic_functions_on_acu_point_info_id"

  create_table "acu_point_therapeutic_functions_symptoms", :id => false, :force => true do |t|
    t.integer "acu_point_therapeutic_function_id"
    t.integer "symptom_id"
  end

  add_index "acu_point_therapeutic_functions_symptoms", ["symptom_id"], :name => "index_acu_point_therapeutic_functions_symptoms_on_symptom_id"

  create_table "acu_points", :force => true do |t|
    t.integer  "channel_id"
    t.integer  "ordinal"
    t.string   "pinyin"
    t.string   "chinese"
    t.text     "name_discussion"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "canonical"
  end

  add_index "acu_points", ["channel_id", "ordinal"], :name => "index_acu_points_on_channel_id_and_ordinal"

  create_table "acu_points_point_combinations", :id => false, :force => true do |t|
    t.integer "point_combination_id"
    t.integer "acu_point_id"
  end

  add_index "acu_points_point_combinations", ["acu_point_id"], :name => "index_acu_points_point_combinations_on_acu_point_id"
  add_index "acu_points_point_combinations", ["point_combination_id"], :name => "index_acu_points_point_combinations_on_point_combination_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["title"], :name => "index_articles_on_title"

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"

  create_table "channels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbreviation"
    t.text     "commentary"
  end

  create_table "citations", :force => true do |t|
    t.integer  "textbook_id"
    t.string   "where"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "citations", ["textbook_id"], :name => "index_citations_on_textbook_id"

  create_table "contraindications", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dui_yaos", :force => true do |t|
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "herb1_id"
    t.integer  "herb2_id"
  end

  add_index "dui_yaos", ["herb1_id"], :name => "index_dui_yaos_on_herb1_id"
  add_index "dui_yaos", ["herb2_id"], :name => "index_dui_yaos_on_herb2_id"

  create_table "dui_yaos_formulas", :id => false, :force => true do |t|
    t.integer  "formula_id"
    t.integer  "dui_yao_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dui_yaos_formulas", ["dui_yao_id"], :name => "index_dui_yaos_formulas_on_dui_yao_id"
  add_index "dui_yaos_formulas", ["formula_id"], :name => "index_dui_yaos_formulas_on_formula_id"

  create_table "formula_comparisons", :force => true do |t|
    t.integer  "formula1_id"
    t.integer  "formula2_id"
    t.text     "formula1_commentary"
    t.text     "formula2_commentary"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "citation_id"
  end

  add_index "formula_comparisons", ["formula1_id"], :name => "index_formula_comparisons_on_formula1_id"
  add_index "formula_comparisons", ["formula2_id"], :name => "index_formula_comparisons_on_formula2_id"

  create_table "formula_contraindications", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "contraindication_id"
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
    t.integer  "position"
    t.integer  "preparation_id"
  end

  add_index "formula_herbs", ["formula_id"], :name => "index_formula_herbs_on_formula_id"
  add_index "formula_herbs", ["herb_id"], :name => "index_formula_herbs_on_herb_id"

  create_table "formula_roles", :force => true do |t|
    t.string   "pinyin"
    t.string   "english"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formula_therapeutic_functions", :force => true do |t|
    t.integer  "formula_id"
    t.integer  "therapeutic_function_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "commentary"
  end

  add_index "formula_therapeutic_functions", ["formula_id"], :name => "index_formula_therapeutic_functions_on_formula_id"
  add_index "formula_therapeutic_functions", ["therapeutic_function_id"], :name => "index_formula_therapeutic_functions_on_therapeutic_function_id"

  create_table "formulas", :force => true do |t|
    t.string   "pinyin"
    t.string   "english"
    t.text     "preparation"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "formula_category_id"
    t.string   "chinese"
    t.integer  "bensky_page"
    t.string   "short_name"
    t.boolean  "state_board"
    t.string   "canonical"
    t.integer  "citation_id"
    t.integer  "source_text_citation_id"
    t.integer  "master_formula_id"
  end

  add_index "formulas", ["canonical"], :name => "index_formulas_on_canonical"
  add_index "formulas", ["citation_id"], :name => "index_formulas_on_citation_id"
  add_index "formulas", ["pinyin"], :name => "index_formulas_on_pinyin"

  create_table "formulas_patterns", :id => false, :force => true do |t|
    t.integer  "formula_id"
    t.integer  "pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formulas_patterns", ["formula_id"], :name => "index_formulas_patterns_on_formula_id"
  add_index "formulas_patterns", ["pattern_id"], :name => "index_formulas_patterns_on_pattern_id"

  create_table "herb_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_category_id"
    t.integer  "position"
    t.integer  "parent_category"
  end

  create_table "herb_comparisons", :force => true do |t|
    t.integer  "herb1_id"
    t.integer  "herb2_id"
    t.integer  "herb3_id"
    t.text     "herb1_commentary"
    t.text     "herb2_commentary"
    t.text     "herb3_commentary"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "herb_comparisons", ["herb1_id"], :name => "index_herb_comparisons_on_herb1_id"
  add_index "herb_comparisons", ["herb2_id"], :name => "index_herb_comparisons_on_herb2_id"

  create_table "herb_flavors", :force => true do |t|
    t.integer  "herb_id"
    t.integer  "flavor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "herb_symptoms", :force => true do |t|
    t.integer  "herb_id"
    t.integer  "symptom_id"
    t.integer  "position"
    t.text     "commentary"
    t.integer  "citation_id"
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
    t.integer  "bensky_page"
    t.string   "common_name"
    t.string   "short_name"
    t.boolean  "state_board"
    t.string   "canonical"
    t.integer  "citation_id"
    t.integer  "source_text_citation_id"
    t.string   "temperature"
  end

  add_index "herbs", ["canonical"], :name => "index_herbs_on_canonical"
  add_index "herbs", ["pinyin"], :name => "index_herbs_on_pinyin"

  create_table "pattern_symptoms", :force => true do |t|
    t.integer  "symptom_id"
    t.integer  "pattern_id"
    t.text     "commentary"
    t.boolean  "maybe"
    t.boolean  "key_symptom"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "pattern_symptoms", ["pattern_id"], :name => "index_pattern_symptoms_on_pattern_id"
  add_index "pattern_symptoms", ["symptom_id"], :name => "index_pattern_symptoms_on_symptom_id"

  create_table "patterns", :force => true do |t|
    t.string   "name"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "citation_id"
    t.string   "tongue"
    t.string   "pulse"
  end

  add_index "patterns", ["citation_id"], :name => "index_patterns_on_citation_id"
  add_index "patterns", ["name"], :name => "index_patterns_on_name"

  create_table "patterns_therapeutic_functions", :id => false, :force => true do |t|
    t.integer  "pattern_id"
    t.integer  "therapeutic_function_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patterns_therapeutic_functions", ["pattern_id"], :name => "index_patterns_therapeutic_functions_on_pattern_id"
  add_index "patterns_therapeutic_functions", ["therapeutic_function_id"], :name => "index_patterns_therapeutic_functions_on_therapeutic_function_id"

  create_table "point_combinations", :force => true do |t|
    t.string   "name"
    t.integer  "citation_id"
    t.integer  "source_text_citation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "point_combinations", ["citation_id"], :name => "index_point_combinations_on_citation_id"

  create_table "point_combinations_symptoms", :id => false, :force => true do |t|
    t.integer "point_combination_id"
    t.integer "symptom_id"
  end

  add_index "point_combinations_symptoms", ["point_combination_id"], :name => "index_point_combinations_symptoms_on_point_combination_id"
  add_index "point_combinations_symptoms", ["symptom_id"], :name => "index_point_combinations_symptoms_on_symptom_id"

  create_table "point_prescription_acu_points", :force => true do |t|
    t.integer  "point_prescription_id"
    t.integer  "acu_point_id"
    t.text     "commentary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reason"
  end

  add_index "point_prescription_acu_points", ["acu_point_id"], :name => "index_point_prescription_acu_points_on_acu_point_id"
  add_index "point_prescription_acu_points", ["point_prescription_id"], :name => "index_point_prescription_acu_points_on_point_prescription_id"

  create_table "point_prescriptions", :force => true do |t|
    t.integer  "pattern_id"
    t.string   "name"
    t.text     "commentary"
    t.integer  "citation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "point_prescriptions", ["citation_id"], :name => "index_point_prescriptions_on_citation_id"
  add_index "point_prescriptions", ["pattern_id"], :name => "index_point_prescriptions_on_pattern_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "symptoms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "symptoms", ["name"], :name => "index_symptoms_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "textbooks", :force => true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbrev"
  end

  add_index "textbooks", ["title"], :name => "index_textbooks_on_title"

  create_table "therapeutic_functions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "therapeutic_functions", ["name"], :name => "index_therapeutic_functions_on_name"

  create_table "users", :force => true do |t|
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "active",              :default => false, :null => false
    t.boolean  "verified",            :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
  end

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

end
