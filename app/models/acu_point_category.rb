class AcuPointCategory < ActiveRecord::Base
  belongs_to :acu_point
  belongs_to :category

  named_association :category, :name, :create => true
  
  scope :with_category_name, lambda{|name|
    cat = Category.named(name)
    id = cat.id if cat 
    joins(:category).where(:categories=>{:id=>id})
  }

end

