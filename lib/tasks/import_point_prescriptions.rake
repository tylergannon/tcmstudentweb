namespace :import do
  require 'logger'
  $POINT_LOG = Logger.new('points.log')
  class NilClass
    def [](a)
    end
    def each
      []
    end
  end
  require 'logger'
  DIRECTORY = "/home/tyler/Dropbox/Documents/Projects/tcm_student_web/Point Prescriptions"
  task :point_prescriptions => :environment do
    require 'yaml'
    
    dir = Dir.open("#{DIRECTORY}")
    diseases = []
    dir.entries.select{|t| t.index("yml")}.each do |file|
      puts "Reading yaml file #{file}"
      YAML::load_file("#{DIRECTORY}/#{file.to_s}").each{|t| diseases << t}
    end
    diseases.each do |dd|
      puts "Entering disease: #{dd[:disease]}"
      tb = Textbook.find_by_abbrev("cam")
      where = dd[:page].to_s
      citation = Citation.where("textbook_id = #{tb.id}").select{|t| t.where = where}[0]
      citation = citation ||= Citation.create(:textbook => tb, :where => where)
      disease = Disease.find_or_create_by_name(dd[:disease])
      disease.citation = citation
      dd[:patterns].each do |pd|
        puts "\tPattern: #{pd[:name]}"
        p = Pattern.where("name = '#{pd[:name]}' and citation_id = #{citation.id}")[0]
        if p
          puts "Pattern #{p.name} already exists.  Clearing it out."
          pattern = Pattern.find(p)
          pattern.pattern_symptoms.each{|ps| ps.destroy}
          pattern.point_prescriptions.each{|pp| pp.destroy}
        else
          puts "Creating pattern #{pd[:name]}."
          pattern = Pattern.create(:name => pd[:name], :citation => citation)
        end
        
        pd[:symptoms].each do |ps|
          pattern.pattern_symptoms << PatternSymptom.create(:symptom_name => ps.match(/[^\(]*/)[0].strip, :commentary => ps.match(/\(([^\)]+)\)/)[0])          
        end
        point_prescription = PointPrescription.create(:pattern => pattern, :citation => citation)
        pd[:points].each {|point_hash| enter_point_hash(point_hash, point_prescription)}
        pd[:supplementary].each {|point_hash| enter_point_hash(point_hash, point_prescription)}
        pattern.save
      end #dd[:patterns]
      disease.save
    end #diseases.each
  end #task :point_prescriptions
  
  def enter_point_hash(point_hash, pp)
    point_hash.each{|key, points|
      points.each {|point|
        ap = AcuPoint.search(point.match(/[^\(]*/)[0].strip)
        if ap.nil?
          puts "Creating extra point #{point}."
          ap = AcuPoint.create(:channel_id => 15, :pinyin => point)
        end
        pp.point_prescription_acu_points << PointPrescriptionAcuPoint.create(:acu_point => ap, :reason => key, :commentary => point.match(/\(([^\)]+)\)/)[0])
      }
    }
    pp.save
  end
end # namespace :import


