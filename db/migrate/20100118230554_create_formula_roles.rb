class CreateFormulaRoles < ActiveRecord::Migration
  def self.up
    create_table :formula_roles do |t|
      t.string :pinyin
      t.string :english

      t.timestamps
    end
		
		FormulaRole.new(:pinyin => "jūn", :english => "Chief").save
		FormulaRole.new(:pinyin => "chén", :english => "Deputy").save
		FormulaRole.new(:pinyin => "zuǒ", :english => "Assistant").save
		FormulaRole.new(:pinyin => "shǐ", :english => "Envoy").save
		
  end

  def self.down
    drop_table :formula_roles
  end
end
