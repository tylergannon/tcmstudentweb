class AddSomeIndexes < ActiveRecord::Migration
  def self.up
    add_index :acu_point_categories, :acu_point_id
    add_index :acu_point_categories, :category_id
    add_index :acu_point_infos, :acu_point_id
    add_index :acu_point_infos, :citation_id
    add_index :acu_point_symptoms, :symptom_id
    add_index :acu_point_symptoms, :acu_point_info_id
    add_index :acu_point_therapeutic_functions, :therapeutic_function_id
    add_index :acu_point_therapeutic_functions, :acu_point_info_id
    add_index :acu_points_point_combinations, :acu_point_id
    add_index :acu_points_point_combinations, :point_combination_id
    add_index :acu_points, [:channel_id, :ordinal]
    add_index :articles, :title
    add_index :categories, :name
    add_index :citations, :textbook_id
    add_index :dui_yaos, :herb1_id
    add_index :dui_yaos, :herb2_id
    add_index :dui_yaos_formulas, :formula_id
    add_index :dui_yaos_formulas, :dui_yao_id
    add_index :formula_comparisons, :formula1_id
    add_index :formula_comparisons, :formula2_id
    add_index :formula_herbs, :formula_id
    add_index :formula_herbs, :herb_id
    add_index :formula_therapeutic_functions, :formula_id
    add_index :formula_therapeutic_functions, :therapeutic_function_id
    add_index :formulas, :pinyin
    add_index :formulas, :canonical
    add_index :formulas, :citation_id
    add_index :formulas_patterns, :formula_id
    add_index :formulas_patterns, :pattern_id
    add_index :herb_comparisons, :herb1_id
    add_index :herb_comparisons, :herb2_id
    add_index :herbs, :pinyin
    add_index :herbs, :canonical
    add_index :pattern_symptoms, :pattern_id
    add_index :pattern_symptoms, :symptom_id
    add_index :patterns, :name
    add_index :patterns, :citation_id
    add_index :patterns_therapeutic_functions, :pattern_id
    add_index :patterns_therapeutic_functions, :therapeutic_function_id
    add_index :point_combinations, :citation_id
    add_index :point_combinations_symptoms, :point_combination_id
    add_index :point_combinations_symptoms, :symptom_id
    add_index :point_prescription_acu_points, :point_prescription_id
    add_index :point_prescription_acu_points, :acu_point_id
    add_index :point_prescriptions, :pattern_id
    add_index :point_prescriptions, :citation_id
    add_index :symptoms, :name
    add_index :taggings, [:taggable_id, :taggable_type, :context]
    add_index :tags, :name
    add_index :textbooks, :title
    add_index :therapeutic_functions, :name

  end

  def self.down
  end
end

