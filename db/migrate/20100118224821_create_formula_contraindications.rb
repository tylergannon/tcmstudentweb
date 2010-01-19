class CreateFormulaContraindications < ActiveRecord::Migration
  def self.up
    create_table :formula_contraindications do |t|
      t.integer :formula_id
      t.integer :contraindication_id

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_contraindications
  end
end
