namespace :import do
  task :formula_names => :environment do
    require 'import_formulas'
    FORMULA_NAMES.each do |fn|
      import_formula fn[0], fn[1], fn[2], fn[3]
    end
  end

  task :herbs => :environment do
    require 'rubygems'
    require 'htmlentities'
    require 'yaml'
    $KCODE = 'UTF8'
    coder = HTMLEntities.new

    dir = Dir.open("lib/herb_data")
    dir.entries.select{|t| t.index("yml")}.each do |file|
      data = YAML::load_file("lib/herb_data/#{file.to_s}")
      herb = Herb.search_equals(data[:canonical])
      if herb
        puts "Found #{herb.pinyin}"
      else
        puts "Creating #{data[:canonical]}"
        herb = Herb.create(:canonical => data[:canonical])
      end
      channels = data[:channels].join(", ") unless data[:channels].nil?
      flavors = data[:flavors].join(", ") unless data[:flavors].nil?
      herb.attributes = {
        :chinese => data[:chinese], :pinyin => data[:pinyin],
        :channel_list => channels,
        :flavor_list => flavors,
        :english => data[:common], :temperature => data[:temperature],
        :contraindications => data[:cautions]
      }
      puts "Error saving #{herb.canonical}: #{herb.errors.inspect}" unless herb.save
    end
  end

  task :acu_points => :environment do
    AcuPointScraper.scrape_acu_points
    require 'lib/tasks/scrape/acu_point_scraper'



  end

  task :formulas => :environment do
#    require 'lib/tasks/scrape/scrape_formulas'
    formulas = YAML::load_file("lib/tasks/formulas.yml")
    formulas.each do |data|
      formula = Formula.search_equals(data[:canonical])
      formula = formula ||= Formula.create(:canonical => data[:canonical])
      formula.pinyin = data[:canonical] if formula.pinyin.empty?
      formula.chinese = data[:chinese]
      formula.english = data[:english] if formula.english.empty?
      puts "unable to save #{formula.pinyin}" unless formula.save
    end
  end

  task :formula_1 => :environment do
    formulas = YAML::load_file("lib/tasks/list.yml")
    formulas.each_pair do |name, page|
      f = Formula.search_equals(name)
      if f.nil?
        puts "Couldn't find #{name}"
      else
        f.citation = f.citation ||= Citation.create(:textbook_id => 2)
        f.citation.where = page
        f.save
      end

    end
  end
end

