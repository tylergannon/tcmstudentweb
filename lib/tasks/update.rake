namespace :update do
  task :tags => :environment do
    Pattern.joins(:citation).where("citations.textbook_id=20").each do |p|
      pattern = Pattern.find(p.id)
      pattern.tag_list << "Maciocia"
      pattern.save
    end
  end
  
  task :functions => :environment do
    TherapeuticFunction.find_each(:batch_size => 50) do |tf|
      TherapeuticFunction.where("lower(name) = '#{tf.name.lower}'").where("id <> #{tf.id}").each{|other| tf.consolidate(other)}
    end
  end
  
  task :formula_dui_yao => :environment do
    Formula.find_each(:batch_size => 50) do |formula|
      herb_ids = formula.formula_herbs.map{|t| t.herb_id}
      formula.dui_yaos = DuiYao.where(:herb1_id => herb_ids).where(:herb2_id => herb_ids)
    end
  end
end

