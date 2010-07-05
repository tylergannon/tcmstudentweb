namespace :edit do
  task :patterns => :environment do
    patterns = Pattern.order(:id).select{|t| t.primary_pattern_list.size == 0}
    
    patterns.each do |p|
      puts p.name
      puts "Taglist=#{p.tag_list}.\n New tags?"
      while (a=gets)!="\n"
        p.tag_list << a.strip
      end
      puts "Primary patterns=#{p.primary_pattern_list}.\n New tags?"
      while (a=gets)!="\n"
        p.primary_pattern_list << a.strip
      end
      p.save
      puts "Saved\n"
    end
  end

end


