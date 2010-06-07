namespace :update do
  task :tags => :environment do
    Pattern.joins(:citation).where("citations.textbook_id=20").each do |p|
      pattern = Pattern.find(p.id)
      pattern.tag_list << "Maciocia"
      pattern.save
    end
  end
end

