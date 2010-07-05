?class RockThePlastic5
  def self.go
    Pattern.order(:id).each do |p|
      if p.primary_pattern_list.size == 0
        puts p.name
        puts p.pattern_symptoms.map{|t| t.symptom_name}.join(", ")
        if p.tag_list.size == 0
          puts "New tags?\n>"
          a=gets.strip
          
          while a["?"] == "?"
            ActsAsTaggableOn::Tag.where("name like '%#{a[0..a.size-2]}%'").each{|t| puts t.name} unless a.empty?
            puts
            a=gets.strip
          end
          a.split(",").map{|t| t.strip}.each{|t| p.tag_list << t} unless a.empty?
        end
        puts "Primary patterns=#{p.primary_pattern_list}.\n Primary Pattern?\n>"
        a=gets.strip
        while a["?"] == "?"
          ActsAsTaggableOn::Tag.where("name like '%#{a[0..a.size-2]}%'").each{|t| puts t.name} unless a.empty?
          puts
          a=gets.strip
        end
        a.split(",").map{|t| t.strip}.each{|t| p.primary_pattern_list << t} unless a.empty?
        p.save
        puts "Saved\n"
      end
    end
  end
end

