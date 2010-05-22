namespace :import do
  task :formula_names => :environment do
    require 'import_formulas'
    FORMULA_NAMES.each do |fn|
      import_formula fn[0], fn[1], fn[2], fn[3]
    end
  end
end

