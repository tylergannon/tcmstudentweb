namespace :import do
  task :formula_names => :environment do
    require 'import_formulas'
    FORMULA_NAMES.each do |fn|
      import_formula fn[0], fn[1], fn[2], fn[3]
    end
  end
  HERBS_DIR = "/home/tyler/Dropbox/Documents/Projects/tcm_student_web/Herbs"
  task :state_board_herbs => :environment do
    dir = Dir.open("#{HERBS_DIR}")
    dir.entries.select{|t| t.index("yml") && !t.index("pages")}.each do |file|
      herb = Herb.named(file.to_s[0..file.to_s.index(".")-1])
      if herb.nil?
        puts "Couldn't find #{file.to_s[0..file.to_s.index(".")-1]}"
      else
        herb.tag_list << "State Board"
        herb.save
      end
    end
  end
  task :herb_functions => :environment do
    require 'yaml'

    dir = Dir.open("#{HERBS_DIR}")
    dir.entries.select{|t| t.index("yml") && !t.index("pages")}.each do |file|
      data = YAML::load_file("#{HERBS_DIR}/#{file.to_s}")
      herb = Herb.named(data[:canonical])
      if herb.nil?
        puts "unable to find #{data[:canonical]}"
      else
        herb.commentary = data[:discussion]
        if data[:bensky].to_i > 0
          if herb.citation.nil?
            herb.citation = Citation.new(:textbook_id =>41, :where => data[:bensky])
          else
            herb.citation.where = data[:bensky]
          end
        end
        if data[:functions].size > 0
          herb.herb_therapeutic_functions.each {|tf| tf.destroy}
          data[:functions].each do |f|
            herb.herb_therapeutic_functions << HerbTherapeuticFunction.create(:therapeutic_function_name => f[:function], :commentary => f[:discussion], :herb_id => herb.id)
          end
        end
        herb.save
      end
    end
  end

  task :get_herb_functions => :environment do
    require 'yaml'

    dir = Dir.open("#{HERBS_DIR}")
    dir.entries.select{|t| t.index("yml") && !t.index("pages")}.each do |file|
      data = YAML::load_file("#{HERBS_DIR}/#{file.to_s}")
      herb = Herb.named(data[:canonical])
      if herb.nil?
        puts "unable to find #{data[:canonical]}"
      else
        data[:discussion] = herb.commentary.strip unless herb.commentary.nil?
        data[:bensky] = herb.citation.where unless herb.citation.nil?
        if herb.citation.nil?
          puts "#{herb.pinyin} has no citation."
        end
        data[:functions] = []
        herb.herb_therapeutic_functions.order(:id).each do |htf|
          data[:functions] << {:function => htf.therapeutic_function_name, :discussion => htf.commentary}
        end
        File.open("#{HERBS_DIR}/#{file.to_s}", "w"){|t| t.write(data.to_yaml)}
      end
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
      herb = Herb.named(data[:canonical])
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
      formula = Formula.named(data[:canonical])
      formula = formula ||= Formula.create(:canonical => data[:canonical])
      formula.pinyin = data[:canonical] if formula.pinyin.empty?
      formula.chinese = data[:chinese]
      formula.english = data[:english] if formula.english.empty?
      puts "unable to save #{formula.pinyin}" unless formula.save
    end
  end

  task :shang => :environment do
    formulas = YAML::load_file("lib/tasks/zhong.yml")
    formulas.each do |info|
      st = (info[:text] == "shang han lun" ? 5 : 2)
      formula = Formula.named(info[:formula])
      if formula.nil?
        puts "Creating #{info[:formula]}"
        formula = Formula.create(:pinyin => info[:formula].titleize)
      end
      formula.citation = formula.citation ||= Citation.create(:textbook_id => 2, :where => info[:page])
      formula.source_text_citation = formula.source_text_citation ||= \
        Citation.new(:textbook_id => st)
      formula.tag_list = formula.tag_list.to_s + ",Shang Han Lun"
      puts "Unable to save #{info[:formula]}" unless formula.save

    end

  end

  task :formula_1 => :environment do
    formulas = YAML::load_file("lib/tasks/list.yml")
    formulas.each_pair do |name, page|
      f = Formula.named(name)
      if f.nil?
        puts "Couldn't find #{name}"
      else
        f.citation = f.citation ||= Citation.create(:textbook_id => 2)
        f.citation.where = page
        f.tag_list = "State Board"
        f.save
      end

    end
  end
end

