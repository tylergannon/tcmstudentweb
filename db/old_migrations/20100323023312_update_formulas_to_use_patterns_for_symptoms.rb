class UpdateFormulasToUsePatternsForSymptoms < ActiveRecord::Migration
  def self.up
    Formula.all do |formula|
      if pattern = formula.formula_patterns[0]
        unless pattern.citation || !formula.citation
          

        end
      end
    end
  end

  def self.down


    create_table "formula_symptoms" do |t|
      t.integer  "formula_id"
      t.integer  "symptom_id"
      t.timestamps
      t.boolean  "maybe"
      t.boolean  "key_symptom"
      t.text     "commentary"
    end
  end
end
