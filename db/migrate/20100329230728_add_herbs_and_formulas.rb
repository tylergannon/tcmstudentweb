class AddHerbsAndFormulas < ActiveRecord::Migration
  def self.up

    Herb.all.each do |h|
      h.canonical = h.canonical.titleize
      h.save
    end

    Formula.all.each do |f|
      f.canonical = f.canonical.titleize
      f.save
    end

    herbs = read_file('doc/Herbs.csv')
    formulas = read_file('doc/Formulas.csv')
    herbs.sort! {|x,y| x[2] <=> y[2]}
    formulas.sort! {|x,y| x[1] <=> y[1]}

    herbs.each do |h|
      herb = Herb.find_or_create_by_canonical(h[2].titleize)
      puts herb.canonical
      herb.pinyin = h[2] if herb.pinyin.blank?
      herb.attributes = {"herb_category_name" => h[1], "chinese" => h[3], "common_name" => h[4], "latin" => h[5]}
      herb.save!
    end

    formulas.each do |h|
      formula = Formula.find_or_create_by_canonical(h[1].titleize)
      puts formula.canonical
      formula.pinyin = h[1] unless formula.pinyin
      formula.attributes = {"formula_category_name" => h[0], "chinese" => h[2], "english" => h[3]}
      formula.save!
    end

#    HerbCategory.all.each do |cat|
#      if cat.herbs.size == 0
#        cat.destroy
#      end
#    end
#
#    FormulaCategory.all.each do |cat|
#      if cat.formulas.size == 0
#        cat.destroy
#      end
#    end

  end

  def self.down
  end

  def self.read_file(f)
    file = File.new(f, 'r')
    result = []
    file.each_line("\n") do |row|
      result << row.split(",").map{|v| v.gsub(/"/, "").strip}
    end
    result
  end
end
