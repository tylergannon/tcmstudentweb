class AcuPointCategory < ActiveRecord::Base
  belongs_to :acu_point
  belongs_to :category

  def name
    category_name
  end
  
  named_association :category, Category, :name, :create

  def key_attributes
    ["id", "category_name","commentary", "position"]
  end
end

