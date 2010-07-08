namespace :update do
  task :tags => :environment do
    Pattern.joins(:citation).where("citations.textbook_id=20").each do |p|
      pattern = Pattern.find(p.id)
      pattern.tag_list << "Maciocia"
      pattern.save
    end
  end
  
  task :formula_dui_yao => :environment do
    DuiYao.find_each(:batch_size=>25) do |dui_yao|
      Formula.find_each(:batch_size=>25) do |formula|
        if formula.herbs.exists?(:id=>dui_yao.herb1_id) && formula.herbs.exists?(:id=>dui_yao.herb2_id)
          formula.dui_yaos << dui_yao
          formula.save
        end
      end
    end
  end
end

